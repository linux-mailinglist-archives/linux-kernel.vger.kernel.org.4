Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25886A6D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCAN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:58:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FB206A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:58:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw28so5002201edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677679107;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3bjN8OSwsuDJqLBpr/dCsURBfPayXDKpfDck7itpPY=;
        b=NH1w30zpPeC4I1U5vI3MMQYktiR+a0t33SDQCGcGddu7sFYSjfVqblqw9mb1Mbs4KM
         xEcmiL5EUaqhBU0dCkevfDGoFtG/E90lu1lT2I0O4/Ln2NpQ/tvp6bQniacsAi0LAFZy
         2iffLonfQUPaFFIc6lHBZEKfogeZL15BdqvZ6PrdKluWpiUoKFVIzdN7MJArwbCFTLou
         S0XAtRh/u9jiQsr7jJ/1ikeZhDFUNFE5hLO1I0jiU5AFNtl+LkXv5KZIZLtOL1mMfXBo
         vFfMgIbHERt+6ykaqsooz0mfku7DqH3y4s6JqspL09eUOy4cdPY3rnAHWo8E6fAKcffK
         Jcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677679107;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3bjN8OSwsuDJqLBpr/dCsURBfPayXDKpfDck7itpPY=;
        b=MUXaRXicyJX0qg9fCDWWzZDk2cKknECYw58VVrLNI7F252lL4Fbx0qwvSQyzt7/plW
         nPkCV4f6SpXPS01IwtCR+kn+eIdjPWbL8Oe6ql5OJURU6ol2It7G1EczUXVhOH+zjTmK
         3rFF0vqdUG1IOuXN1aizZHcc7av7c4YfO/NJQUKuOCce6Qa1PcQZ6R8ARfO8tMXyOEXn
         EmWkTfFOykAaHE/JRs43Wa40/HIZ9QA+LK9EAk6tAdFJ9Cf9F4AnOsPiiMzBNgxyNU2d
         nRCpSl7QHbbeJ5Xm0805hQKovXjIyMQYdXH8zSgaWUAHoXDOjnbbtim40dt7aDpXWEi3
         oN5w==
X-Gm-Message-State: AO0yUKVZmTlYnhHmOt7rRfMkWVuMZ8ghXZ4kHKV7mWeaW58QvGdqGWWd
        Y/OklKEuk0bZLcbRoeFsWPKYd2lAQ68Dk3NYFVjc/WrRGiQ=
X-Google-Smtp-Source: AK7set9fKRd9slA7k0Z7ejNLz1iMrDoR7tgM0axH5VTPkd/jZcmbd5k1seG6ctpBaRPEVI1n5xOnhRurugn7AEPaEho=
X-Received: by 2002:a17:906:fe06:b0:8f8:edfc:b68b with SMTP id
 wy6-20020a170906fe0600b008f8edfcb68bmr5586841ejb.6.1677679107415; Wed, 01 Mar
 2023 05:58:27 -0800 (PST)
MIME-Version: 1.0
From:   Patrice Duroux <patrice.duroux@gmail.com>
Date:   Wed, 1 Mar 2023 14:58:15 +0100
Message-ID: <CAGKjw9KHDnVgRz5bstJYkq4t0-bT5fvkuQZbEB48d-8jo4Q00g@mail.gmail.com>
Subject: a tiny patch related to two shell scripts that use 2&>1 in place of 2>&1
To:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003ec07005f5d71bcb"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003ec07005f5d71bcb
Content-Type: text/plain; charset="UTF-8"

Hi,

Further to the following item reported to the Debian QA mailing list:
https://lists.debian.org/debian-qa/2023/02/msg00052.html
here is attached a patch regarding two possible candidates in the
linux source tree.

Regards,
Patrice

--0000000000003ec07005f5d71bcb
Content-Type: text/x-patch; charset="US-ASCII"; name="linux_scripts.patch"
Content-Disposition: attachment; filename="linux_scripts.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lepqkylk0>
X-Attachment-Id: f_lepqkylk0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkX29mZmNwdS5zaCBiL3Rv
b2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkX29mZmNwdS5zaAppbmRleCBlMDE5NzNkNGUwZmIu
LmYwNjJhZTlhOTVlMSAxMDA3NTUKLS0tIGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmRf
b2ZmY3B1LnNoCisrKyBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkX29mZmNwdS5zaApA
QCAtNjUsNyArNjUsNyBAQCB0ZXN0X29mZmNwdV9jaGlsZCgpIHsKIAogICAjIHBlcmYgYmVuY2gg
c2NoZWQgbWVzc2FnaW5nIGNyZWF0ZXMgNDAwIHByb2Nlc3NlcwogICBpZiAhIHBlcmYgcmVjb3Jk
IC0tb2ZmLWNwdSAtZSBkdW1teSAtbyAke3BlcmZkYXRhfSAtLSBcCi0gICAgcGVyZiBiZW5jaCBz
Y2hlZCBtZXNzYWdpbmcgLWcgMTAgPiAvZGV2L251bGwgMiY+MQorICAgIHBlcmYgYmVuY2ggc2No
ZWQgbWVzc2FnaW5nIC1nIDEwID4gL2Rldi9udWxsIDI+JjEKICAgdGhlbgogICAgIGVjaG8gIkNo
aWxkIHRhc2sgb2ZmLWNwdSB0ZXN0IFtGYWlsZWQgcmVjb3JkXSIKICAgICBlcnI9MQpkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvZHNhL3Rlc3RfYnJpZGdl
X2ZkYl9zdHJlc3Muc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcml2ZXJzL25ldC9kc2Ev
dGVzdF9icmlkZ2VfZmRiX3N0cmVzcy5zaAppbmRleCBhMWYyNjllZTg0ZGEuLjkyYWNhYjgzZmJl
MiAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvZHNhL3Rl
c3RfYnJpZGdlX2ZkYl9zdHJlc3Muc2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJp
dmVycy9uZXQvZHNhL3Rlc3RfYnJpZGdlX2ZkYl9zdHJlc3Muc2gKQEAgLTMxLDcgKzMxLDcgQEAg
dHJhcCAnY2xlYW51cCcgRVhJVAogCiBldGg9JHtORVRJRlNbcDFdfQogCi1pcCBsaW5rIGRlbCBi
cjAgMiY+MSA+L2Rldi9udWxsIHx8IDoKK2lwIGxpbmsgZGVsIGJyMCAyPiYxID4vZGV2L251bGwg
fHwgOgogaXAgbGluayBhZGQgYnIwIHR5cGUgYnJpZGdlICYmIGlwIGxpbmsgc2V0ICRldGggbWFz
dGVyIGJyMAogCiAod2hpbGUgOjsgZG8K
--0000000000003ec07005f5d71bcb--
