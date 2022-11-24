Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622D63713D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKXDpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKXDpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:45:49 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DE10D4;
        Wed, 23 Nov 2022 19:45:48 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 128so423112vsz.12;
        Wed, 23 Nov 2022 19:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CPKIuCUVqvoXjJBT5OG33wh3hTUjcahfD7x6JjejEw=;
        b=l9FX/mvmG3ZDFdIg0Dh6i2eSdfwI2KgR2LwDENRw/ry3R6BLnI0VkS3Dgke/iIurR6
         b23pseaF8VzEnd8uBg6W0AQ8FKctL8Mlp/3aRzjFD00vAFKk1wjdqjV3Uyu35WC4BInw
         aEEOyEU/tuXyHo4H3beWKhiPdZQLGXPiXpyfYCDTIBEJP3wdRLq/nhUIhLWRa7hnbMib
         D0WiM1pzAto4Aj+Beq8AfxEhSdTKnlfqQsP3rmdtc9qKPbU8DgSUXngGCLaBoULCLx48
         uP1M4vgOkzdoo/QUo33fEVq03u94b40LJa1UMgqb+A4dIkIVsp7OOlf6AfVEMFFxzP9x
         +mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CPKIuCUVqvoXjJBT5OG33wh3hTUjcahfD7x6JjejEw=;
        b=DY9dqc0Jds3my/Ded+U3t+6Af8uuQr86P/deqqUk3e7GMo7o8gwHvopWD5FHSIGy0h
         9y+whQiASrJeqLW4zN9SbF8Rxof+TNWMx1zM5A7LwDDNo66qoYh8zdye4vMykwgZY4rd
         qGSyNANMOOmGsoTypZtb72m/Eq3c8sbLMcXKtCKXvpBIVbt0hCra/5Ogp25L2J8vzjII
         gsrXz1slV3PqkFaVgMtv/WMyWGTiAI6AOQCUksCamigWrK3PDYO9MQb1QXutvo3eXoJA
         Iqy665E9IqNvqnfdRa22ilR1MeyIRshLfNaLXQGXxvbJ1ikg5szY0aruBJtEfCb3f0uF
         UwhA==
X-Gm-Message-State: ANoB5pkmsi0Pv5QMaIK5APOJKo+ZTnyrSLzZN5PFbST6OCqVmUdErjw1
        7leKocEYIWSoJGR/+mHMUAE6KtaMu1f0V6ycSBY=
X-Google-Smtp-Source: AA0mqf4JL6iIJCd9AkmeeowxoY9GON5Kyy5dquooYyFHAfVdHDRzh2JiOvxgOqodsdWCUtYdUSq11MpCPVadt2k3ZkE=
X-Received: by 2002:a05:6102:1e:b0:3ac:3e44:e649 with SMTP id
 j30-20020a056102001e00b003ac3e44e649mr7837955vsp.63.1669261547637; Wed, 23
 Nov 2022 19:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20221122085724.3245078-1-milkfafa@gmail.com> <20221122085724.3245078-3-milkfafa@gmail.com>
 <20221123000552.GA817752-robh@kernel.org>
In-Reply-To: <20221123000552.GA817752-robh@kernel.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 24 Nov 2022 11:45:36 +0800
Message-ID: <CADnNmFq_1+OJNWCGSjmyV=sB39TNvAjKVs_1uLN8rOJ_RQNPSQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] media: dt-binding: nuvoton: Add bindings for NPCM
 VCD and ECE engine
To:     Rob Herring <robh@kernel.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
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

Hi Rob,

Thanks for the review.

> > +title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings
>
> Drop ' Device Tree Bindings'
>
> > +
> > +maintainers:
> > +  - Joseph Liu <kwliu@nuvoton.com>
> > +  - Marvin Lin <kflin@nuvoton.com>
> > +
> > +description: |
> > +  Video Capture/Differentiation Engine (VCD) and Encoding Compression Engine
> > +  (ECE) present on Nuvoton NPCM SoCs.
>
> Sounds like 2 h/w blocks? If so, then it should be 2 separate nodes.
>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm750-video
> > +      - nuvoton,npcm845-video
>
> 'video' doesn't sound like the name of the h/w block(s).

VCD and ECE are 2 h/w blocks and our video capture driver needs to
control their registers.
If I separate them and store a phandle (referring to ece node) in vcd
node like this:

vcd: vcd@f0810000 {
    compatible = "nuvoton,npcm750-vcd";
    reg = <0xf0810000 0x10000>;
    ...
    nuvoton,enc-engine = <&ece>;
};

ece: ece@f0820000 {
    compatible = "nuvoton,npcm750-ece";
    reg = <0xf0820000 0x2000>;
    ...
};

Does it look good to you?

Regards,
Marvin
