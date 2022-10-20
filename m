Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82871605E86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJTLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJTLNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:13:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C51E0981
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:13:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m16so29414467edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdnm0e4L4egQY8p/imzEdF1XvlB/g201L2c/ublTFpo=;
        b=dLLmNvj9ms0bzvYlgFq5S3nAOVEBj6b4h8ts8CH0M6BZRCPrassOfs87hYp7M7g7Uz
         95DibTwR/HG6v32WUdnix6iSHZlZvRoRaEZx/fa12VWLBCKvuBST/9Ns2/D23SyOLczz
         Fhs5cjYYjW3e6tBTF/MAb2jt8+30MjT590ADcIKIbSEtKknVTu3xpvx8CDIdL3Pj5cL4
         l6f3KoVNBoxk7YOtG+3dApM2a9GBalv/+JOJYnP/KCTOpfqAAxrx39IaVcdpup7CBgF0
         gdre418CpWtFK7Qdj16TlKP6Tz9yBeSDIsyrVe0T1UHvP+r0kF0Ir09aMiJqZqqv0rjC
         yJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdnm0e4L4egQY8p/imzEdF1XvlB/g201L2c/ublTFpo=;
        b=yAfyY6g/KtNZjqkP5AdqJ7ddHbW0BTfX/3kK7savhJ7BE7wD2YJ91DaM1X+fH0+XG0
         SlIya6FdP3NIALe/fT+h5aJnkqdt/RkZmlsNnqlm3sG+XlI/758H5/TWFsoeWIhCOhbj
         pkGy614Do+V4a0GSVbvHtLgKsX/fzY9cmCacGu+pw4MbmLRpFzME3f5tnsS905vwPyFJ
         DyfJIXWLaLk1EaMr3Qlrl1ja5E/pRwUfeXZPUZ8mH8YqvgVUdTy28Qnqe0M+GOzzEYZU
         OKgXJ3ydWtW9F/b1SjNvqHFlSYe8nvzng6Kz/+zrXw6OoMrFtitCfKO/nnieSNJfqebL
         KbKA==
X-Gm-Message-State: ACrzQf17k+RN9CRxPr7o5dvoTK2OxUUkK+mc5WO32mAEf38MTQpg4viX
        2Y7vS7YyZ45sG9rl3/gtf/WGcz6Q8v1BJeo9lX8=
X-Google-Smtp-Source: AMsMyM6TJTr+1CBYy7z4zliNV7Z2vYiHb8I4Al6D3i9j+ck6tYUXqhsVbonKiT5oTBdc+Mj9jZuI2mPFenIi8gCtgH0=
X-Received: by 2002:a05:6402:2074:b0:458:ad26:d5c2 with SMTP id
 bd20-20020a056402207400b00458ad26d5c2mr12162647edb.332.1666264389291; Thu, 20
 Oct 2022 04:13:09 -0700 (PDT)
MIME-Version: 1.0
From:   Sarah Laura <demandgenerationslead@gmail.com>
Date:   Thu, 20 Oct 2022 06:12:54 -0500
Message-ID: <CAKhOGSq5PcHhFTJsXUDn4_4Hk97qXpEUrquHLamE2RzXJX2O0Q@mail.gmail.com>
Subject: RE: Gartner Security Attendees Data Lists-2022
To:     Sarah Laura <demandgenerationslead@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you are having a productive day

Would you be interested in acquiring Gartner Security & Risk
Management Attendees Databank?

List Includes:- Org-Name, First Name Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more

Contact   :  6,623 Verified Contacts.
Cost          :  $1,425

Kind Regards,
Sarah Laura
Marketing Coordinator

To break off kindly reply with "Leave Out" in the subject line.
