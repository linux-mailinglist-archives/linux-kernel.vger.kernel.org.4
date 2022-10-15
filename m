Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE735FF9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJOL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJOL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:59:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6573B1FE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:59:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b12so10058565edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDLYp/dw7BRujZAoDLh3hqROYdnMn+L6d9sILtjV6xo=;
        b=YN0EXxeZmaZnhWzrVCHT9oH7sMdtqt0zU6mCKoDuEPsSXotLH2dRBsqg4ZPo1SsmQz
         QLE1fp4nFI6cG9yZkYb+u6HcHxevPdd8JI0cpvaVQIu2FOXcfQmpQe5E3c/otq7NRE2k
         sYsU6tXE9l07oR4m7NdMVSjMeekRP6pi91VggSWkFdh7buz43Nw6aNZ1mSPzr+veMhve
         W6C487VNLZ/rhga/IeUCAhH8TsuR251R9octvTS+fD6ARD6L/oW+TD528+Haa5xTlf5p
         XvpjFfGj12/s06gUUDpXE6kvJbtqv8gT2xz9jGKSr2dczK+NzYQgcfZwNo9JR6wxihfz
         rA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDLYp/dw7BRujZAoDLh3hqROYdnMn+L6d9sILtjV6xo=;
        b=pJTYRljuILMlr9/u6vRmlxerAlICUq/RV4wW2t830YkejBW3VcWAbTA7sCwhvHqf08
         DoKtK3rchHKB6Af3gRtDwwXUB6MBd44x6wY7NwiOGr6jf+3YANfFOdTcGvLCQ3TG/Bem
         m8cizNDOwDyeuOJ1AL0baW9dp8zWf3nkVLMx+GULno6lnqGEKFjFDM5Nq23Z5aAP4nwC
         tRerNrdnq2HfKff7icusoTaHzBPGCLROPPWu07JdgOItoM3ryjxSF8ncw2iiQGjywvxl
         EGemLLDHi3sjYS6SdHupTJ40WAQSRXkQ4JoqjMWhYskQCittanRHQvUvrBzAgA76yuVM
         dn2g==
X-Gm-Message-State: ACrzQf2Z9uE/xFF71k/zBivh/9j0KZLAM12kNo8ulqs9UxR/jcNFiBS6
        UUknvdLMy6p3UXS4YDcXmeBSG4l76QFxcjIuYn8=
X-Google-Smtp-Source: AMsMyM5EErUrJGdioQIu0CD9fFmqEeDpjWpe7KYxS6D2OObfQ3CV6clsQP5gwZ7bRRHX0MUspn7R5TDzvTcaQ1KH79w=
X-Received: by 2002:a50:fe0a:0:b0:458:dce8:2b6b with SMTP id
 f10-20020a50fe0a000000b00458dce82b6bmr2009249edt.84.1665835167169; Sat, 15
 Oct 2022 04:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:5681:b0:5b:b927:c45d with HTTP; Sat, 15 Oct 2022
 04:59:26 -0700 (PDT)
Reply-To: attorneyjoel4ever.tg@gmail.com
From:   Felix Joel <edmond.djamond@gmail.com>
Date:   Sat, 15 Oct 2022 11:59:26 +0000
Message-ID: <CAAORCvVRBM3GOtc-3Q5bBC6Fo-bswcwQoSmb66x0UGFwUqV5RA@mail.gmail.com>
Subject: =?UTF-8?B?xI1la8OhbSBuYSB2YcWhaSBvZHBvdsSbxI8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpBaG9qLA0KUHJvc8OtbSwgcMWZaWptxJt0ZSBtb2ppIG9tbHV2dS4gTmVjaGNpIG5hcnXF
oW92YXQgdmHFoWUgc291a3JvbcOtLCBqc2VtDQpGZWxpeCBKb2VsLCBwxa92b2Ruw61tIHBvdm9s
w6Fuw61tIHByw6F2bsOtay4gTmFwc2FsIGpzZW0gdsOhbSBkxZnDrXbEm2rFocOtDQplLW1haWws
IGFsZSBiZXogb2Rwb3bEm2RpIGEgdmUgc3bDqW0gcHJ2bsOtbSBlLW1haWx1IGpzZW0gc2UgdsOh
bSB6bcOtbmlsIG8NCm3DqW0gemVzbnVsw6ltIGtsaWVudG92aSwga3RlcsO9IG3DoSBzdGVqbsOp
IHDFmcOtam1lbsOtIGpha28gdnkuIE9kIGplaG8NCnNtcnRpIGpzZW0gb2JkcsW+ZWwgbsSba29s
aWsgZG9waXPFryBvZCBqZWhvIGJhbmt5LCBrZGUgcMWZZWQgc3ZvdSBzbXJ0w60NCnByb3ZlZGwg
dmtsYWQsIGJhbmthIG3EmyBwb8W+w6FkYWxhLCBhYnljaCBwb3NreXRsIGplaG8gbmVqYmxpxb7F
ocOtbQ0KcMWZw61idXpuw71tIG5lYm8gbsSba3RlcsOpbXUgeiBqZWhvIHDFmcOtYnV6bsO9Y2gs
IGt0ZcWZw60gbW9ob3UgdXBsYXRuaXQgbsOhcm9rDQpuYSBqZWhvIGZpbmFuxI1uw60gcHJvc3TF
mWVka3ksIGppbmFrIGJ1ZG91IHphYmF2ZW55IGEgb2QgdMOpIGRvYnkNCk5lcG9kYcWZaWxvIHNl
IG1pIG5hasOtdCDFvsOhZG7DqWhvIHogamVobyBwxZnDrWJ1em7DvWNoLiBSb3pob2RsIGpzZW0g
c2UgdsOhcw0Ka29udGFrdG92YXQgcyB0w61tdG8gbsOhcm9rZW0sIG3DoXRlIHMgbsOtbSBzdGVq
bsOpIHDFmcOtam1lbsOtLiBrb250YWt0dWp0ZQ0KbcSbIG5hbMOpaGF2xJsgcHJvIGRhbMWhw60g
cG9kcm9ibm9zdGkuDQpTIHBvemRyYXZlbSwNCkFkdm9rw6F0IEZlbGl4IEpvZWwNCg==
