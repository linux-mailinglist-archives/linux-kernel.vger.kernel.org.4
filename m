Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00EB622146
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKIBRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIBRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:17:10 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685EE23175;
        Tue,  8 Nov 2022 17:17:08 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so15286989vsh.5;
        Tue, 08 Nov 2022 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYcTTuwI7G46p7K3ucaiKME/7Z+rBfUYDVp4gpPf4Ac=;
        b=Vcd0RkQmc/NMRf9OtDQvHNa9UBq0feaRI/Rh376FTe7DgUXmxDDxj9wq5+tIM60IJ+
         cbeLAL10iy6VBXCP00djE6RoFsQRK32Xg0DAmi15mokOfnfhxmyQNJ8EtI5hX5Yx+5eP
         kTJok8wP6bKnfGmKkSDPlz3wWvceycUW2D+/uU1/Tf8QNyvogHV4u4NS1Ma6E71Pvm4b
         PxQfzKasJg1iegehqZy/DJCMlWOYWtkyJA9P0Z4iIKYGpOgTY7Gt/bl7CWkypFH5D950
         ebomLEYl+a6Hu1eUrInZvu+DLlwydorFjbaoMnmx1mb03sW+XlDS1UJ+8Wf3Mequ4T3L
         Urwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYcTTuwI7G46p7K3ucaiKME/7Z+rBfUYDVp4gpPf4Ac=;
        b=vhgYeSSE9ulx9qBnCn4SodjiUFwxHfClPMvYhe/A2seSV1L1BysnGwPZOBzYZV2ZZn
         20Ow6M38F05AUh9CS/ndNrgKdZPQ28QWnNdATSItZo8HobhxWMEFNsWG6xATuxZaX6dH
         LJ2+n71yOCn7SVonSpbqC4mimZg3rn+XcogF2eeBzYOXbJ3eHd7pykDT1sNvRSEcMBdJ
         Bzdu4k3qRDm3FrI5/J3STsu7JBzJKCG6VOJH1JcufyONP+7Qmmv+tlkQXqSELFTh/FSc
         1ZMxOvsMyorimQfVXtNA4zLdRz0THwlUxJDiSmLDNsYrgY62F40giJwr/tUBf8Nu3U1R
         bVRQ==
X-Gm-Message-State: ANoB5pmseC50Uk0uooFGDD6ZQkNT+fC/tK8VKFXmHNzi222ZtyB6Vut9
        Eh4fJHYe0qnNTRpQ8t2tVmymwJTcnAKOFQ/OPu8=
X-Google-Smtp-Source: AA0mqf7Sc5Q+GlFsu+HUXcVUH8rWVMsE2xMY4ahp9uHHaJ+ye3ydGB3+4WuZsI6pb+6UYqOsaKOcp1ci90zFVx4Tkug=
X-Received: by 2002:a67:b809:0:b0:3ae:9298:114c with SMTP id
 i9-20020a67b809000000b003ae9298114cmr15583vsf.64.1667956627444; Tue, 08 Nov
 2022 17:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20221104033810.1324686-1-milkfafa@gmail.com> <20221104033810.1324686-6-milkfafa@gmail.com>
 <357a3098-918b-895b-7305-0f1a63aacdb0@xs4all.nl> <CADnNmFp4r-3+pvHa+_HOxcXAkORadMzgg6fFKbLcgs66a_90gw@mail.gmail.com>
 <daab81c3-4592-5ef0-5a0e-5f89fe58a3e7@xs4all.nl>
In-Reply-To: <daab81c3-4592-5ef0-5a0e-5f89fe58a3e7@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Wed, 9 Nov 2022 09:16:56 +0800
Message-ID: <CADnNmForsJJD=PickWqfsnKdLoMp=0xx70=9foNAJn9hYyy9vw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

>
> This is very much a driver-specific control. So you have to make your
> own.
>
> This series is a good example on how to add a custom control:
>
> https://lore.kernel.org/linux-media/20221028023554.928-1-jammy_huang@aspeedtech.com/
>
> Driver-specific controls are fine, as long as they are properly documented.

Thanks for the advice, I'll add our own custom control.

Regards,
Marvin
