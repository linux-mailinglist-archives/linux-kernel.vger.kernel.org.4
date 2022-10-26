Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54560E8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiJZTXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiJZTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:23:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EB82868;
        Wed, 26 Oct 2022 12:23:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so19459011wrh.1;
        Wed, 26 Oct 2022 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=XEgcn2r/w5ULwp6/az3hFeCeqevUoLHujjaPkWBEloY=;
        b=hxpGP57OCodC7yn5vO4V2LyPIixSPYpfWTiZQrnU6ptMawnFbtI2rVvcoS8olTP2WS
         gpv1JTpBNXlY87xOp0ikVV82E3W58Pz+OrK+RvvQCGg1QO0JIst3F/SNlnfhYNOkQd25
         CXvdUZRJVpCTE/7fhLPN4iA+/22Imv1KKL8XM9gR3lo/SYWL2WOTV9TNFgrSUVOpN8Di
         mHDIxrouTMYqQGug5iFiwOW36ktcPaQFJGRwqcOaXKsCKA2+gSGK+OSPOX4VuZKPPLAS
         bXmMJtN7Ung+7NBDJP+fCK01nXDzFwQmloWIE2IzjudSf2HUnZ0NRYnjJm4qr9LYJbvw
         Ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEgcn2r/w5ULwp6/az3hFeCeqevUoLHujjaPkWBEloY=;
        b=ekEm0snNqkbKiNs01Bh7rsQhpCz4PUv/4428sDZtseGDE32GEAH85UEs8zreX/n5Vy
         XVz501gDdusTiuzryxTPl7mqBkDiRHMgRUHvavmwSDpbQfv9Vr42iGP6D8higmWuo508
         EIVnlHv5Cr6KqYpdgKYGXVJze0hUXb1yFxyHtDrZh0/MAh8X3JAcUx0o2zes2lsRDmr9
         dySnMfeTvHgmgpGT9Kalid0UZ0/WeUGwMDZ+O9y2i6jnauKffroX42IfmN6SMNBAvlyz
         NgZliqE45hLrZ4+33laqFrGSR9+LeghMWUhdchZxwV78AezMdaR6hnemIs7R/0+AKhuk
         T2BA==
X-Gm-Message-State: ACrzQf3DHj17S6pZVAV0veQIbqsm6YcT6DS5UU/GRLS6TaGHyPBkBYLd
        R35TeJO5OWMVCUb2Zdj58G6qTF0BSt1Dkw==
X-Google-Smtp-Source: AMsMyM5QS3AYzIeljW/LCYF9j0fMMLIAvoGJKJBMiI4Bmw6zNI7dhLrfmUbYpRCmVqHA5XS9Xs5Vtg==
X-Received: by 2002:a5d:47cd:0:b0:22e:f98e:3b0b with SMTP id o13-20020a5d47cd000000b0022ef98e3b0bmr29646658wrc.556.1666812179741;
        Wed, 26 Oct 2022 12:22:59 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id bt18-20020a056000081200b002366b241cf3sm6192997wrb.35.2022.10.26.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:22:59 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <Y1Z74/vKHbnaCLrX@sirena.org.uk>
 <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
 <Y1fCfej+/WH8TI39@sirena.org.uk>
 <FgO8Xz5MtaEBdBidpT8So4X5posjL95Y@localhost>
 <Y1lOLgLNDgsmvfe5@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
In-reply-to: <Y1lOLgLNDgsmvfe5@sirena.org.uk>
Date:   Wed, 26 Oct 2022 20:22:59 +0100
Message-ID: <3vVkKn5WAgfH6HITfpqZP3wEVaTf1Kvc@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Wed, Oct 26, 2022 at 03:42:31PM +0100, Aidan MacDonald wrote:
>> Mark Brown <broonie@kernel.org> writes:
>>
>>> There is a strong case for saying that all the clocking in CODECs might
>>> fit into the clock API, especially given the whole DT thing.
>>>
>> The ASoC APIs don't speak "struct clk", which seems (to me) like a
>> prerequisite before we can think about doing anything with clocks.
>
> Right, they probably should.

Let me throw out an idea then... the clock API will probably need to
gain the ability to express constraints, eg. limit a clock to set of
frequencies or frequency ranges; ratio constraints to ensure a set of
clocks are in one of a specified set of ratios; and maybe require that
certain clocks be synchronous.

This'd go a long way toward making the clock API suitable for audio
clocking.

>> Even if ASoC began to use the clock API for codec clocking, it's not
>> clear how you maintain backward compatibility with the existing
>> simple-card bindings. You'd have to go over all DAIs and mimic the
>> effects of "snd_soc_dai_set_sysclk(dai, 0, freq, dir)" because there
>> could be a device tree relying on it somewhere.
>
> Of course, you'd need to define bindings for devices with multiple
> clocks such that things continue to work out compatibly.
>
>> So... given you're already stuck maintaining .set_sysclk() behavior
>> forever, is there much harm in exposing the sysclock ID to the DT?
>
> Yes, it's ABI and the more baked in this stuff gets the more issues we
> have when trying to integrate with the wider clock tree in the system -
> for example when devices are able to output their system clock to be
> used as a master clock for a device which can use the clock API as an
> input.  It's fine in kernel but we should be trying to keep it out of
> ABI.

Fair enough. It's too bad this limits the usefulness of simple-card,
but for the time being I'm happy maintaining these patches out of tree.

Regards,
Aidan
