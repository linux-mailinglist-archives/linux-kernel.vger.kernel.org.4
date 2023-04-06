Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354FA6D9CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjDFP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbjDFP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:59:04 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A09755;
        Thu,  6 Apr 2023 08:59:03 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w133so29403411oib.1;
        Thu, 06 Apr 2023 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796743; x=1683388743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh7h3jMxLokPLKNPs7kQpXzC9xXuYjOjp2sgIXgC2jU=;
        b=rvbeNofsvZDZLb0ltwxN+lET8hbSlB+dPnBYG8RF4o3SIKPepcCgQWCkFXSvQ+7+C2
         KdY3O3XYvojYgDgMsQBpXFUkuELNo4seklJgh3neIcijPhREbUr7i1G0t+how6mYuyDT
         6GqrM6GLicc1r0oSVxV2Yk2IgGAaG4s6IUrNMBhQLlJEc+B7AtNzSJXAyVPxKkXOrFSc
         XRv4qLk5F4e93hP2u9H56MgBR0dGuT0BpKbkneYcEpB2kqNb/hp5IYp1x8+emHWIqw+v
         uLaCXwFE2C7DoyMoI3pjXd2HbvnnCqynfvnXhiQxWtz14h95QXJHp5qgthLBEN5nOH/d
         jdUQ==
X-Gm-Message-State: AAQBX9ew6QVWoQhBBfKWksjieZuE9lEL0NymtNcHfmt7RNWYyv6aKwUg
        fT+IxTefBP8+VXkrLnRYrHwHFIYzpg==
X-Google-Smtp-Source: AKy350arKIELgvEJntEgvZm0kaiU+d+z/2nRm9Qv5wpmftvqcCoU9kxkvuhMhE6BIYSSc7apiG4Jew==
X-Received: by 2002:a05:6808:5:b0:383:e1f3:fef6 with SMTP id u5-20020a056808000500b00383e1f3fef6mr2910633oic.18.1680796743189;
        Thu, 06 Apr 2023 08:59:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020aca6707000000b0038755008179sm780181oix.26.2023.04.06.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:59:02 -0700 (PDT)
Received: (nullmailer pid 3159384 invoked by uid 1000);
        Thu, 06 Apr 2023 15:59:02 -0000
Date:   Thu, 6 Apr 2023 10:59:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Patrick Lai <quic_plai@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: soundwire: qcom: add 16-bit sample
 interval
Message-ID: <168079674130.3159330.8680786687198930722.robh@kernel.org>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 15:24:58 +0200, Krzysztof Kozlowski wrote:
> The port sample interval was always 16-bit, split into low and high
> bytes.  This split was unnecessary, although harmless for older devices
> because all of them used only lower byte (so values < 0xff).  With
> support for Soundwire controller on Qualcomm SM8550 and its devices,
> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
> to allow 16-bit sample intervals.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soundwire/qcom,soundwire.yaml    | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

