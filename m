Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2256680335
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjA3ACN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3ACL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:02:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF761ADE5;
        Sun, 29 Jan 2023 16:02:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so16724655lfb.1;
        Sun, 29 Jan 2023 16:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M7mFhCHIKrDAQRw7JizbyIbXXiHSGBAj4H5t/HZyGaI=;
        b=nlShhLXf/jHipfUCYV6b6qycV63aU00ybPUuuRiVKeka6CZM8zCQzR50L9lqvx30h8
         jWihkptmVb8M74jH2WVYV7YPidP7FuS3SpwK8/cYANy15j5X29e8l/eU6voJDZGpLsEQ
         6PwLYZ/rNQcCS+J6UgxmOfCFj8EKn7Xup0meLNHMzJifYrPNuX59C68o88hx2kziQ57x
         ioPp6IxUxNuE2f0zT8U+LiTNaFn0hXF4Twd5fg8UZT0IqzrRufhAs7mRVpfN59mmr6qh
         pAY+nhc3zPk1zSzAOMXVP+CB3TDIXF2agHsa7yhgnuZLtrO6qL5Gt++fekVTfmALK66k
         /o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7mFhCHIKrDAQRw7JizbyIbXXiHSGBAj4H5t/HZyGaI=;
        b=ryJDvs8eNaIFE1IqkCB/sVoR/1GGYudQsEDpYUKbqPk+JeD3qtkwqbgSQEzdMcjaQ8
         P0x5OIwRYcIRMMh09jIFpibcaRWj/Q+2MjRdnBOKIBZ2fpHjYztTsqygP7Kb7iq606FH
         r7N5V3JGWLmUhD9QpuPbWXrUFw+2+1dk/keVdGONI/0dgE4/qxLEAt0IZR1xymjkh3BE
         O5UsVC55CYceJ8OJSnY371lNrXdkn6mrgSQ3BcFGWEKV4r+pTPplNf0D1RKH6aL1Mn8h
         C3lPRcrApIq7DXp9ZiWzxC4HvlyDMMHTq16+hIwgwO5zXRZPaPELB/2KoqH3vsgymkGh
         x+Zg==
X-Gm-Message-State: AO0yUKUv/MCNqtTSgtn/KJSOCG4ivg2XtvaaUdl8ckcMcZheBSItCRBr
        q1sG8jZ//JPsLm4xhiKwt6Fgr0E4oWnf1FszHULq3QGO7ME=
X-Google-Smtp-Source: AK7set9pJqL+fdWIUFYrgAiC3sKFyZ0wyie5NSzoMn6opifeFbzS9g5YmcJ0TagQvEoYLHbPDWyuXNBA5l6j4msJ5BE=
X-Received: by 2002:a19:c219:0:b0:4d7:2dc1:b7bc with SMTP id
 l25-20020a19c219000000b004d72dc1b7bcmr1968783lfc.100.1675036928246; Sun, 29
 Jan 2023 16:02:08 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 29 Jan 2023 18:01:56 -0600
Message-ID: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
Subject: [PATCH][KSMBD] fix indentation in ksmbd config and note Kerberos support
To:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000018359305f36fedec"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000018359305f36fedec
Content-Type: text/plain; charset="UTF-8"

Fix indentation of server config options, and also since
support for very old, less secure, NTLM authentication was removed
(and quite a while ago), remove the mention of that in Kconfig, but
do note Kerberos (not just NTLMv2) which are supported and much
more secure.

Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index e1fe17747ed6..4153e5491435 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -33,17 +33,18 @@ config SMB_SERVER
    in ksmbd-tools, available from
    https://github.com/cifsd-team/ksmbd-tools.
    More detail about how to run the ksmbd kernel server is
-   available via README file
+   available via the README file
    (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).

    ksmbd kernel server includes support for auto-negotiation,
    Secure negotiate, Pre-authentication integrity, oplock/lease,
    compound requests, multi-credit, packet signing, RDMA(smbdirect),
    smb3 encryption, copy-offload, secure per-user session
-   establishment via NTLM or NTLMv2.
+   establishment via Kerberos or NTLMv2.

 config SMB_SERVER_SMBDIRECT
  bool "Support for SMB Direct protocol"
+ depends on SMB_SERVER
  depends on SMB_SERVER=m && INFINIBAND && INFINIBAND_ADDR_TRANS ||
SMB_SERVER=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
  select SG_POOL
  default n

-- 
Thanks,

Steve

--00000000000018359305f36fedec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ksmbd-update-Kconfig-to-note-Kerberos-support-and-fi.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-update-Kconfig-to-note-Kerberos-support-and-fi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ldi1oc650>
X-Attachment-Id: f_ldi1oc650

RnJvbSBmZWIxMWQwMzRjYjM2ZTg2Mjk5ZjZmNWYwZmQ3NTJhZmNlNWM3ZmQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFN1biwgMjkgSmFuIDIwMjMgMTc6NDk6NTkgLTA2MDAKU3ViamVjdDogW1BBVENIXSBr
c21iZDogdXBkYXRlIEtjb25maWcgdG8gbm90ZSBLZXJiZXJvcyBzdXBwb3J0IGFuZCBmaXgKIGlu
ZGVudGF0aW9uCgpGaXggaW5kZW50YXRpb24gb2Ygc2VydmVyIGNvbmZpZyBvcHRpb25zLCBhbmQg
YWxzbyBzaW5jZQpzdXBwb3J0IGZvciB2ZXJ5IG9sZCwgbGVzcyBzZWN1cmUsIE5UTE0gYXV0aGVu
dGljYXRpb24gd2FzIHJlbW92ZWQKKGFuZCBxdWl0ZSBhIHdoaWxlIGFnbyksIHJlbW92ZSB0aGUg
bWVudGlvbiBvZiB0aGF0IGluIEtjb25maWcsIGJ1dApkbyBub3RlIEtlcmJlcm9zIChub3QganVz
dCBOVExNdjIpIHdoaWNoIGFyZSBzdXBwb3J0ZWQgYW5kIG11Y2gKbW9yZSBzZWN1cmUuCgpTaWdu
ZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Cgpmb28KLS0t
CiBmcy9rc21iZC9LY29uZmlnIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9rc21iZC9LY29uZmlnIGIvZnMv
a3NtYmQvS2NvbmZpZwppbmRleCBlMWZlMTc3NDdlZDYuLjQxNTNlNTQ5MTQzNSAxMDA2NDQKLS0t
IGEvZnMva3NtYmQvS2NvbmZpZworKysgYi9mcy9rc21iZC9LY29uZmlnCkBAIC0zMywxNyArMzMs
MTggQEAgY29uZmlnIFNNQl9TRVJWRVIKIAkgIGluIGtzbWJkLXRvb2xzLCBhdmFpbGFibGUgZnJv
bQogCSAgaHR0cHM6Ly9naXRodWIuY29tL2NpZnNkLXRlYW0va3NtYmQtdG9vbHMuCiAJICBNb3Jl
IGRldGFpbCBhYm91dCBob3cgdG8gcnVuIHRoZSBrc21iZCBrZXJuZWwgc2VydmVyIGlzCi0JICBh
dmFpbGFibGUgdmlhIFJFQURNRSBmaWxlCisJICBhdmFpbGFibGUgdmlhIHRoZSBSRUFETUUgZmls
ZQogCSAgKGh0dHBzOi8vZ2l0aHViLmNvbS9jaWZzZC10ZWFtL2tzbWJkLXRvb2xzL2Jsb2IvbWFz
dGVyL1JFQURNRSkuCiAKIAkgIGtzbWJkIGtlcm5lbCBzZXJ2ZXIgaW5jbHVkZXMgc3VwcG9ydCBm
b3IgYXV0by1uZWdvdGlhdGlvbiwKIAkgIFNlY3VyZSBuZWdvdGlhdGUsIFByZS1hdXRoZW50aWNh
dGlvbiBpbnRlZ3JpdHksIG9wbG9jay9sZWFzZSwKIAkgIGNvbXBvdW5kIHJlcXVlc3RzLCBtdWx0
aS1jcmVkaXQsIHBhY2tldCBzaWduaW5nLCBSRE1BKHNtYmRpcmVjdCksCiAJICBzbWIzIGVuY3J5
cHRpb24sIGNvcHktb2ZmbG9hZCwgc2VjdXJlIHBlci11c2VyIHNlc3Npb24KLQkgIGVzdGFibGlz
aG1lbnQgdmlhIE5UTE0gb3IgTlRMTXYyLgorCSAgZXN0YWJsaXNobWVudCB2aWEgS2VyYmVyb3Mg
b3IgTlRMTXYyLgogCiBjb25maWcgU01CX1NFUlZFUl9TTUJESVJFQ1QKIAlib29sICJTdXBwb3J0
IGZvciBTTUIgRGlyZWN0IHByb3RvY29sIgorCWRlcGVuZHMgb24gU01CX1NFUlZFUgogCWRlcGVu
ZHMgb24gU01CX1NFUlZFUj1tICYmIElORklOSUJBTkQgJiYgSU5GSU5JQkFORF9BRERSX1RSQU5T
IHx8IFNNQl9TRVJWRVI9eSAmJiBJTkZJTklCQU5EPXkgJiYgSU5GSU5JQkFORF9BRERSX1RSQU5T
PXkKIAlzZWxlY3QgU0dfUE9PTAogCWRlZmF1bHQgbgotLSAKMi4zNC4xCgo=
--00000000000018359305f36fedec--
