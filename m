Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3906ED2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjDXQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDXQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:40:30 -0400
X-Greylist: delayed 953 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 09:40:21 PDT
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD5876BB;
        Mon, 24 Apr 2023 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=smNFfWYZDzCdeMK2Jp8UC6yG66GXW3bdYd
        Cd5GyzDhc=; b=gbhP58M97zPzv/37DsaIKaQ0fORdRWpNhTVkU0XfWDJ4vWgjth
        wHhGpwviy8whL4i3U/BennGlb9xW+dK5EjhTlxW4XiGpa2mOqraMk1Epx06R924j
        ZETpdL6doCImayur9yXwJuL04C5GdspwiDvqeOdZQPytoaENLuNFRfZyc=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogD3fz59rEZkQRscAA--.27563S2;
        Tue, 25 Apr 2023 00:21:22 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     torvalds@linux-foundation.org, masahiroy@kernel.org
Cc:     arnd@arndb.de, bp@alien8.de, dave.hansen@linux.intel.com,
        devel@acpica.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, rafael@kernel.org,
        robert.moore@intel.com, terrelln@fb.com, tglx@linutronix.de,
        trix@redhat.com, x86@kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH] scripts: Remove ICC-related dead code
Date:   Tue, 25 Apr 2023 00:21:10 +0800
Message-Id: <20230424162110.11082-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20221016182349.49308-1-masahiroy@kernel.org>
References: <20221016182349.49308-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogD3fz59rEZkQRscAA--.27563S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFy7Kry8WF1rXF4kZrW5ZFb_yoW8JF1Upa
        yjk34qgr1kZr4S9r1xAw10qF1rAan7t3yxCw1jgF1jkF13Gr40qrWxtFyakr98Za18trWF
        9FW8A343Gr43CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw2
        0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIE
        c7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
        IEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy77qNLwASsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel compiler support has already been completely removed in commit
95207db8166a ("Remove Intel compiler support"). However, it appears that
there is still some ICC-related code in scripts/cc-version.sh. There is
no harm in leaving the code as it is, but removing the dead code makes
the codebase a bit cleaner.

Hopefully all ICC-related stuff in the build scripts will be removed
after this commit, given the grep output as below:

	(linux/scripts) $ grep -i -w -R 'icc'
	cc-version.sh:ICC)
	cc-version.sh:	min_version=$($min_tool_version icc)
	dtc/include-prefixes/arm64/qcom/sm6350.dtsi:#include <dt-bindings/interconnect/qcom,icc.h>

Fixes: 95207db8166a ("Remove Intel compiler support")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 scripts/cc-version.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
index 0573c92e8..a7e28b6a5 100755
--- a/scripts/cc-version.sh
+++ b/scripts/cc-version.sh
@@ -45,10 +45,6 @@ Clang)
 	version=$2.$3.$4
 	min_version=$($min_tool_version llvm)
 	;;
-ICC)
-	version=$(($2 / 100)).$(($2 % 100)).$3
-	min_version=$($min_tool_version icc)
-	;;
 *)
 	echo "$orig_args: unknown C compiler" >&2
 	exit 1
-- 
2.40.0

