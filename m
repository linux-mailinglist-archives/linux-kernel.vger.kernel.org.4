Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5E74192D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjF1UBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjF1UBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:01:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459221FEB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:01:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso114802276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687982466; x=1690574466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pH8fcOy6rMWZ3uve7XV8TBdo5xEMK41yysafMwoH2IE=;
        b=qz9jHSQcQn2Eqv5Gcrj+63LutKi3Xyivczb45g2I/oid/NwcQYB2znuVTukvLXbnYh
         dQ1yCw8Nl/3jRnxBEBKJkON41/9l/WA/O5Z4STYAaBQ/HI6MCloeJnqwq/FYEmtwOt9j
         LqmsVf/132+dYgy+aDN8haLR3sHea+wzGg7ekrV4hr8JlpdLCIF9hvrbIuYX3l0xILNL
         ZwCUwEFvkqy12tPJhIpKFmTabXkNF0FEZN/m1qeW6R1ieMsmBWuOOCHxEIvEqiWET/dL
         WtAl1QYoLpy0eWsyqQIRbtUkAKjzJl/Qzr6uAb+o4Oft4N6JFgrNNltd3kSE5SCQZnvc
         i6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982466; x=1690574466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH8fcOy6rMWZ3uve7XV8TBdo5xEMK41yysafMwoH2IE=;
        b=E/StYszsqTJeaIJuZzZj91Y8Hc5Iht8peXqYrdJ3Ww7SFH+RJhrpD0T/JJThcUtvcs
         27cun6xQmq41sO7c+cOpW10NxG1roJot2t2tQtaVkhQVREIhLYUbsvsxBAbluvHPSDer
         A2wbvGvicoVtB6c3aFHbcrAu6/4mrDs1O7Zq/+7s6R+3Ei3dSMNS5OVXnqI7on/hu471
         CRcGmAry1XCPYHI8U7U1Vla4uCWuKNZgDEHK1xj+2JV6MSQ+/IBSfHazqAlG5l/qI3DM
         aVbtgsvt+3VukDhiab5JLgNtcsAQnCWs7rUqgdJrVQU+WQCBeMxzqvyNxYbrDpCK8LBO
         OKKw==
X-Gm-Message-State: AC+VfDw+/jxXmIXxy//gyV8tEuSNfTpEB4ZPtWAZSQQdXK5nWUxoIa8X
        3K7OnfMgNL7a3U8N3gTxVKyK6BglvSu7xEehrgSVUA==
X-Google-Smtp-Source: ACHHUZ6rTGYn4z21ozH/ZLqZuWscx/1Ssm6RMV9/o+OjoTbuk1Ka/cUauz/o8y4vIJHKAGz4vpE/C0fYCOszLgRZI54=
X-Received: by 2002:a25:da96:0:b0:c1b:4078:b136 with SMTP id
 n144-20020a25da96000000b00c1b4078b136mr11126494ybf.63.1687982466408; Wed, 28
 Jun 2023 13:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org> <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
 <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org> <c377aefe-2678-4ba7-96b3-2186e8f3f1b4@sirena.org.uk>
 <fabef33c-a8c7-af61-80b4-91e55081c977@linaro.org> <c5bbdaa9-43fb-4ec3-af7d-b1629d2d88f7@sirena.org.uk>
In-Reply-To: <c5bbdaa9-43fb-4ec3-af7d-b1629d2d88f7@sirena.org.uk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 28 Jun 2023 23:00:54 +0300
Message-ID: <CAA8EJprRH6aFj17A-sJzzHJXG7vNWu-yznSh7oA3WBXRv19wvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 22:40, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 28, 2023 at 10:33:16PM +0300, Dmitry Baryshkov wrote:
> > On 28/06/2023 21:10, Mark Brown wrote:
>
> > > If the goal here is to put all the firmwares for a given board in a
> > > single place surely it would be better to factor this all out of the
> > > individual drivers so that they ask some helper for a directory to use
> > > for firmware?  Adding these device specific firmware node properties
> > > doesn't seem to follow.
>
> > This quickly becomes overcomplicated. Some platforms use different firmware
> > naming structure. Some firmware goes into a generic location and other files
> > go into device-specific location. So having a generic helper doesn't really
> > help.
>
> That sounds like a job for symlinks surely?

Excuse me, but I don't understand the goal for such symlinks. In my
opinion (and more importantly, in the opinion of qcom maintainers),
firmware-name does the necessary job. It provides enough flexibility
and doesn't require any additional dances around.



-- 
With best wishes
Dmitry
