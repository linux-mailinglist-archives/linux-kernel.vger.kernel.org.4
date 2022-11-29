Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F363C3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiK2PbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiK2PbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:31:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D364576
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:31:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so8770071plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fVszqxgQ016BSb5qNf+hCvyWQbfpRSMkXlPPrp4GVI=;
        b=bSoOisz9I9mHhMJiRBlqA98mcW26hkx7Xp/+fcTXZMmZBqyh1NAeNuhydDzv6eniZC
         UnhSBrDa3rOJUZ0VLUoEvXiSqNsAhcw3I5PiP8hpBWT6Pt33fbt+MTOr3911YUILLMsx
         X7d39KEEaQg0aOqHk6fOE6sy6Y5atjhFiv53VzRKof/3dSjO4BVCCWNCgZLcku1xFegj
         eNnGq+i7vNumxfZVraDv0AlhybJTPThiFPFGXaHDCFRAv3Q96CyDdeGMCILaRv82dd6z
         y3jPFZvGNVxeggjlx8KnjL0sl1novb60iZwlh0keCyMvHVdG11rFb6lmUFPdi/NOyK8K
         sLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fVszqxgQ016BSb5qNf+hCvyWQbfpRSMkXlPPrp4GVI=;
        b=I6Dm6OnGCItd+Jafxxm5LH6yY3tt2V/UmE2jb67UX19Tr6cMpcWc0adGH2KXJlLLNV
         yXZAy60DMuSVW+WNj3ujBEt0BM4DWDmf1Gig1SZrXLLuq3O7EnomHIv3p60F6RuzE2xg
         iA/OR/MJTRCvLMNPZI6Ht/OIFh0ZlCaBFMpgkeweGoF00afQmc/6dj9OYOQwa46qy4zf
         afQTJgcaJQKzJYUovXrfWXzsAAFZ0TFadk84Ew5PM4hkrsn+JdGny/DZufGGqzk8HFBi
         mG0YfV7JX+XzyohWn7wQh4gxz42zhKiZj6PH0OL7ITlKMEGQrgLMhQ8aj/Gxxg/JxLuF
         hbhw==
X-Gm-Message-State: ANoB5pnnQyvt6f8XcMb3uqxrldxYMYUFa3ayCOeH6eqHVzGOTeq8Le3+
        rGqD9qd6xjOmMuBCRraoF5/ZW0Ud0RS8Hjoxnh4lMA==
X-Google-Smtp-Source: AA0mqf5ik5i4ChFnRvy/bmtuc8PRZp06XQinOIdUlzKVikOtmWsKfjSysf196kcbBAdsx08nJT52ptjgdMON40RNQ9k=
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id
 v11-20020a170902d68b00b00188cca8df29mr44499277ply.148.1669735873662; Tue, 29
 Nov 2022 07:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com> <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
In-Reply-To: <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 16:30:37 +0100
Message-ID: <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less confusing
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 at 13:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/11/2022 12:11, Christoph Niedermaier wrote:
> > The current comment on wakeup-source is a bit confusing, because it isn't
> > clear at first sight which property is actually deprecated.
> > Change the comment to one that is less confusing.
>
> It's still confusing - you mention some non-existing property. I don't
> think it's worth to touch it. If you insist, drop entire comment...

Hmm, it doesn't look that easy to me. The "enable-sdio-wakeup" is
indeed a deprecated wakeup property [1], but it seems like it's not
really described somewhere. I wouldn't mind removing it (as it seems
to add some confusions), but in that case it needs to be entirely
removed from the DT docs, right?

Another option, would be to add a proper description of the property
and mark it with "deprecated: true".

>
> >
> > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> > ---
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: kernel@dh-electronics.com
> > Cc: linux-mmc@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > index 802e3ca8be4d..a921442c6c1d 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -293,7 +293,7 @@ properties:
> >      description:
> >        SDIO only. Preserves card power during a suspend/resume cycle.
> >
> > -  # Deprecated: enable-sdio-wakeup
> > +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
> >    wakeup-source:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:

Kind regards
Uffe

[1]
Documentation/devicetree/bindings/power/wakeup-source.txt
