Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A16AB2BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCEWCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCEWCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:02:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B5166C2;
        Sun,  5 Mar 2023 14:01:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 325JgEhd019526;
        Sun, 5 Mar 2023 22:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=bjWeEMifOcD55Rxlec89GpiaL0XwVoZZhbZxR7kTiHY=;
 b=lrOk9QqK6PIN32ZZSJfCKjMMRAq5NoywosbiGgWoIPiX+r3NHypVKi/pK8G8vM4qD7mX
 QZT8n90uHgTUlkG2ycmbDYjZlQfJKhGwOQBmRcpdtou7ncr8on54x8RawKBVRxL8is4L
 3sEa2cslcQc0jWJkIBZezHKy6xAzG9oD3K0H0SCW9HkM1F33JHYhBV7QrOzOMIzuH2Q/
 dNDfRriMvgngQEHQ0ea3OTjNt37H2g4cw3eAK35cQtvgf87lSCTJFR9QvSWTn0+dDybX
 EC2Dpn15Q/sztBj9y8SgFVWrFAtps9GDhNU/JXyY6lEMoGs/TJipejUdBBcVi5O9vCes Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41561rr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 325I1ZH0023251;
        Sun, 5 Mar 2023 22:00:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u040m80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Mar 2023 22:00:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 325M0Nr1013622;
        Sun, 5 Mar 2023 22:00:33 GMT
Received: from t460.home (dhcp-10-175-35-7.vpn.oracle.com [10.175.35.7])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4u040ktj-2;
        Sun, 05 Mar 2023 22:00:33 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jiri Kosina <jikos@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        Minchan Kim <minchan@kernel.org>,
        Jeimi Lee <jamee.lee@samsung.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v3 1/7] Documentation/security-bugs: move from admin-guide/ to process/
Date:   Sun,  5 Mar 2023 23:00:04 +0100
Message-Id: <20230305220010.20895-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
In-Reply-To: <20230305220010.20895-1-vegard.nossum@oracle.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303050192
X-Proofpoint-GUID: g0x6rYn1b-RDa9pCgqgx6CgD9j-XqeVE
X-Proofpoint-ORIG-GUID: g0x6rYn1b-RDa9pCgqgx6CgD9j-XqeVE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina, Jonathan Corbet, and Willy Tarreau all expressed a desire
to move this document under process/.

Create a new section for security issues in the index and group it with
embargoed-hardware-issues.

I'm doing this at the start of the series to make all the subsequent
changes show up in 'git blame'.

Existing references were updated using:

  git grep -l security-bugs ':!Documentation/translations/' | xargs sed -i 's|admin-guide/security-bugs|process/security-bugs|g'
  git grep -l security-bugs Documentation/translations/ | xargs sed -i 's|Documentation/admin-guide/security-bugs|Documentation/process/security-bugs|g'
  git grep -l security-bugs Documentation/translations/ | xargs sed -i '/Original:/s|\.\./admin-guide/security-bugs|\.\./process/security-bugs|g'

Notably, the page is not moved in the translations (due to my lack of
knowledge of these languages), but the translations have been updated
to point to the new location of the original document where these
references exist.

Link: https://lore.kernel.org/all/nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm/
Suggested-by: Jiri Kosina <jikos@kernel.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Hu Haowen <src.res@email.cn>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Jeimi Lee <jamee.lee@samsung.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/admin-guide/index.rst                      | 1 -
 Documentation/admin-guide/reporting-issues.rst           | 4 ++--
 Documentation/process/howto.rst                          | 2 +-
 Documentation/process/index.rst                          | 9 ++++++++-
 Documentation/process/researcher-guidelines.rst          | 2 +-
 Documentation/{admin-guide => process}/security-bugs.rst | 0
 Documentation/process/stable-kernel-rules.rst            | 2 +-
 Documentation/process/submitting-patches.rst             | 2 +-
 .../translations/it_IT/admin-guide/security-bugs.rst     | 2 +-
 .../translations/it_IT/process/submitting-patches.rst    | 2 +-
 Documentation/translations/ja_JP/howto.rst               | 2 +-
 Documentation/translations/ko_KR/howto.rst               | 2 +-
 Documentation/translations/sp_SP/howto.rst               | 2 +-
 .../translations/sp_SP/process/submitting-patches.rst    | 2 +-
 .../translations/zh_CN/admin-guide/security-bugs.rst     | 2 +-
 Documentation/translations/zh_CN/process/howto.rst       | 2 +-
 .../translations/zh_TW/admin-guide/security-bugs.rst     | 2 +-
 Documentation/translations/zh_TW/process/howto.rst       | 2 +-
 MAINTAINERS                                              | 4 ++--
 19 files changed, 26 insertions(+), 20 deletions(-)
 rename Documentation/{admin-guide => process}/security-bugs.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0ad7e7ec0d27..09a563bbe3e7 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -36,7 +36,6 @@ problems and bugs in particular.
 
    reporting-issues
    reporting-regressions
-   security-bugs
    bug-hunting
    bug-bisect
    tainted-kernels
diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index ec62151fe672..2fd5a030235a 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -395,7 +395,7 @@ might want to be aware of; it for example explains how to add your issue to the
 list of tracked regressions, to ensure it won't fall through the cracks.
 
 What qualifies as security issue is left to your judgment. Consider reading
-Documentation/admin-guide/security-bugs.rst before proceeding, as it
+Documentation/process/security-bugs.rst before proceeding, as it
 provides additional details how to best handle security issues.
 
 An issue is a 'really severe problem' when something totally unacceptably bad
@@ -1269,7 +1269,7 @@ them when sending the report by mail. If you filed it in a bug tracker, forward
 the report's text to these addresses; but on top of it put a small note where
 you mention that you filed it with a link to the ticket.
 
-See Documentation/admin-guide/security-bugs.rst for more information.
+See Documentation/process/security-bugs.rst for more information.
 
 
 Duties after the report went out
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index cb6abcb2b6d0..deb8235e20ff 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -138,7 +138,7 @@ required reading:
     philosophy and is very important for people moving to Linux from
     development on other Operating Systems.
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     If you feel you have found a security problem in the Linux kernel,
     please follow the steps in this document to help notify the kernel
     developers, and help solve the issue.
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index d4b6217472b0..565df595152e 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -35,6 +35,14 @@ Below are the essential guides that every developer should read.
    kernel-enforcement-statement
    kernel-driver-statement
 
+For security issues, see:
+
+.. toctree::
+   :maxdepth: 1
+
+   security-bugs
+   embargoed-hardware-issues
+
 Other guides to the community that are of interest to most developers are:
 
 .. toctree::
@@ -47,7 +55,6 @@ Other guides to the community that are of interest to most developers are:
    submit-checklist
    kernel-docs
    deprecated
-   embargoed-hardware-issues
    maintainers
    researcher-guidelines
 
diff --git a/Documentation/process/researcher-guidelines.rst b/Documentation/process/researcher-guidelines.rst
index afc944e0e898..9fcfed3c350b 100644
--- a/Documentation/process/researcher-guidelines.rst
+++ b/Documentation/process/researcher-guidelines.rst
@@ -68,7 +68,7 @@ Before contributing, carefully read the appropriate documentation:
 * Documentation/process/development-process.rst
 * Documentation/process/submitting-patches.rst
 * Documentation/admin-guide/reporting-issues.rst
-* Documentation/admin-guide/security-bugs.rst
+* Documentation/process/security-bugs.rst
 
 Then send a patch (including a commit log with all the details listed
 below) and follow up on any feedback from other developers.
diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/process/security-bugs.rst
similarity index 100%
rename from Documentation/admin-guide/security-bugs.rst
rename to Documentation/process/security-bugs.rst
diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 2fd8aa593a28..51df1197d5ab 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -39,7 +39,7 @@ Procedure for submitting patches to the -stable tree
 
    Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
-   :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
+   :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
 
 For all other submissions, choose one of the following procedures
 -----------------------------------------------------------------
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index eac7167dce83..7b223f306efa 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -254,7 +254,7 @@ If you have a patch that fixes an exploitable security bug, send that patch
 to security@kernel.org.  For severe bugs, a short embargo may be considered
 to allow distributors to get the patch out to users; in such cases,
 obviously, the patch should not be sent to any public lists. See also
-Documentation/admin-guide/security-bugs.rst.
+Documentation/process/security-bugs.rst.
 
 Patches that fix a severe bug in a released kernel should be directed
 toward the stable maintainers by putting a line like this::
diff --git a/Documentation/translations/it_IT/admin-guide/security-bugs.rst b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
index 18a5822c7d9a..20994f4bfa31 100644
--- a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
+++ b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+:Original: :ref:`Documentation/process/security-bugs.rst <securitybugs>`
 
 .. _it_securitybugs:
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index c2cfa0948b2b..167fce813032 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -272,7 +272,7 @@ embargo potrebbe essere preso in considerazione per dare il tempo alle
 distribuzioni di prendere la patch e renderla disponibile ai loro utenti;
 in questo caso, ovviamente, la patch non dovrebbe essere inviata su alcuna
 lista di discussione pubblica. Leggete anche
-Documentation/admin-guide/security-bugs.rst.
+Documentation/process/security-bugs.rst.
 
 Patch che correggono bachi importanti su un kernel già rilasciato, dovrebbero
 essere inviate ai manutentori dei kernel stabili aggiungendo la seguente riga::
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 9b0b3436dfcf..8d856ebe873c 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -167,7 +167,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
     このドキュメントは Linux 開発の思想を理解するのに非常に重要です。
     そして、他のOSでの開発者が Linux に移る時にとても重要です。
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     もし Linux カーネルでセキュリティ問題を発見したように思ったら、こ
     のドキュメントのステップに従ってカーネル開発者に連絡し、問題解決を
     支援してください。
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 969e91a95bb0..34f14899c155 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -157,7 +157,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
     리눅스로 전향하는 사람들에게는 매우 중요하다.
 
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     여러분들이 리눅스 커널의 보안 문제를 발견했다고 생각한다면 이 문서에
     나온 단계에 따라서 커널 개발자들에게 알리고 그 문제를 해결할 수 있도록
     도와 달라.
diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/translations/sp_SP/howto.rst
index f9818d687b54..f1629738b49d 100644
--- a/Documentation/translations/sp_SP/howto.rst
+++ b/Documentation/translations/sp_SP/howto.rst
@@ -135,7 +135,7 @@ de obligada lectura:
      de Linux y es muy importante para las personas que se mudan a Linux
      tras desarrollar otros sistemas operativos.
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     Si cree que ha encontrado un problema de seguridad en el kernel de
     Linux, siga los pasos de este documento para ayudar a notificar a los
     desarrolladores del kernel y ayudar a resolver el problema.
diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index bf95ceb5e865..c2757d9ab216 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -276,7 +276,7 @@ parche a security@kernel.org. Para errores graves, se debe mantener un
 poco de discreción y permitir que los distribuidores entreguen el parche a
 los usuarios; en esos casos, obviamente, el parche no debe enviarse a
 ninguna lista pública. Revise también
-Documentation/admin-guide/security-bugs.rst.
+Documentation/process/security-bugs.rst.
 
 Los parches que corrigen un error grave en un kernel en uso deben dirigirse
 hacia los maintainers estables poniendo una línea como esta::
diff --git a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
index b8120391755d..d6b8f8a4e7f6 100644
--- a/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_CN/admin-guide/security-bugs.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :doc:`../../../admin-guide/security-bugs`
+:Original: :doc:`../../../process/security-bugs`
 
 :译者:
 
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 10254751df6a..cc47be356dd3 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -125,7 +125,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     这篇文档对于理解Linux的开发哲学至关重要。对于将开发平台从其他操作系
     统转移到Linux的人来说也很重要。
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     如果你认为自己发现了Linux内核的安全性问题，请根据这篇文档中的步骤来
     提醒其他内核开发者并帮助解决这个问题。
 
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index eed260ef0c37..15f8e9005071 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Original: :doc:`../../../admin-guide/security-bugs`
+:Original: :doc:`../../../process/security-bugs`
 
 :譯者:
 
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 8fb8edcaee66..ea2f468d3e58 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -128,7 +128,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     這篇文檔對於理解Linux的開發哲學至關重要。對於將開發平台從其他操作系
     統轉移到Linux的人來說也很重要。
 
-  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
+  :ref:`Documentation/process/security-bugs.rst <securitybugs>`
     如果你認爲自己發現了Linux內核的安全性問題，請根據這篇文檔中的步驟來
     提醒其他內核開發者並幫助解決這個問題。
 
diff --git a/MAINTAINERS b/MAINTAINERS
index b0db911207ba..ed84d41353a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -73,7 +73,7 @@ Tips for patch submitters
 	and ideally, should come with a patch proposal. Please do not send
 	automated reports to this list either. Such bugs will be handled
 	better and faster in the usual public places. See
-	Documentation/admin-guide/security-bugs.rst for details.
+	Documentation/process/security-bugs.rst for details.
 
 8.	Happy hacking.
 
@@ -18807,7 +18807,7 @@ F:	include/uapi/linux/sed*
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
 S:	Supported
-F:	Documentation/admin-guide/security-bugs.rst
+F:	Documentation/process/security-bugs.rst
 
 SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
-- 
2.40.0.rc1.2.gd15644fe02

