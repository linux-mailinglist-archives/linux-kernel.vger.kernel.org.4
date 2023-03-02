Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31016A8B77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCBWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCBWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:06:32 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B401210E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:06:32 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id l2so573855ilg.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677794791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hKjpuFR3iRCin5nJ/ge/tzKffSShcSbKBCteHpDjHE=;
        b=b7CBqubSQlZKzaWYYMpewiuoWGUKKaIGSHfXodoCMaLDrCBOXSr+tfeY/LzQYl1ReB
         WteJoiq939IqZHgN8boAum2ew+jGvmbo13bafJToTcGp7uakJ5wwmKt6MOSFjNQ25kDA
         3ZlvBFq7jpohbSDKJrAPNluy3pydOMaLLMk3ItcHHE1Crkt03QBLvlfRM9+LzSoWCQ9Q
         FT/Omyjuvz0nPuHcpoI9gN6Wz+PDpkKjWhgdmp76qG2/qRbwhO9N0HNruqT1CuwqVjGv
         DM7vM+Cq1h/lHrYPjV0QQ76KkrebV43l05epN6i7ao9MTjieJOViVWQCzf463BLzcl2G
         KNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hKjpuFR3iRCin5nJ/ge/tzKffSShcSbKBCteHpDjHE=;
        b=coU8q1yewC9fqc4YPvXzT1Zc3yflmiNjLZ8PFOgrGHQAO8eyf+/0m2MvvhPoizvjJG
         dmfHadxJdg+LNY5Dk37I87QBOPRRUoCMS637/MLUd8YOyU2rZJkgte315f90t6JXsXPP
         QZlMi19rt2OSl+xq6VCOtrP5rVnWLsgtPO8khE9tt/T8I1OqK/4jLUqbCDbHBcsVGZUR
         INkpQK6OVp7W/K/EVhchTWbWhpr/vjOW621O4mJxvLaPNOOqc1f6Af8CKGfxDr2oI9jc
         jP8S16oTCbbAUiyG5V+Azwww4HkFEenlmjcorl/g970jM7qxZduWTNI8g48iu1IIfLcY
         zjwg==
X-Gm-Message-State: AO0yUKW53wVQInFxRnGmiZgFdMksc9HMRLEwyJ6sZzmIcykuYGNYxmeM
        KyEkqcnXi7rk1dSa6+T40LKa4+yARtFgQDUy
X-Google-Smtp-Source: AK7set+mTm4NPHyROYJg48O0RxzUHoTIPQZgUVA9bEcd/SQWBLPAHOa77XgKIhyauj8Zm3UJDl6w5g==
X-Received: by 2002:a17:902:e542:b0:19c:b7a9:d4a4 with SMTP id n2-20020a170902e54200b0019cb7a9d4a4mr14082873plf.37.1677794258858;
        Thu, 02 Mar 2023 13:57:38 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:f233:886c:8482:e0ce])
        by smtp.gmail.com with ESMTPSA id kn13-20020a170903078d00b00189e7cb8b89sm151118plb.127.2023.03.02.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:57:38 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:57:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, corbet@lwn.net,
        quic_visr@quicinc.com
Subject: Re: [PATCH v5 0/2] Update section header name check
Message-ID: <20230302215735.GA1401708@p14s>
References: <20230223150559.2429562-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223150559.2429562-1-quic_mohs@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 08:35:57PM +0530, Mohammad Rafi Shaik wrote:
> Update section header name check and corresponding documentation.
> Changes since v4:
>     -- Rephrase commit message.

Asked for clarifications on V4 that were never given to me.  This patchset will
not move forward until those have been resolved.

> Changes since v3:
>     -- Rephrase commit message.
> Changes since v2:
>     -- Update the commit message with example.
>     -- Update the documentation text appropriately.
> Changes since v1:
>     -- Update the commit message.
>     -- Use strstarts instead of strstr.
>     -- Update documentation file.
> 
> Srinivasa Rao Mandadapu (2):
>   remoteproc: elf_loader: Update resource table name check
>   docs: remoteproc: Update section header name requirement
> 
>  Documentation/staging/remoteproc.rst       | 5 ++++-
>  drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 
