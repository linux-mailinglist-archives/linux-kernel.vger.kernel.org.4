Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D3656565
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiLZWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiLZWgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:01 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8C38BA;
        Mon, 26 Dec 2022 14:35:53 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id v62-20020a4a7c41000000b004a0a214dfbaso1979391ooc.9;
        Mon, 26 Dec 2022 14:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObGasMJPGQMGOlrO4jpeqYoN1QjAy+4BnnehCr9SQ4c=;
        b=Xuv0RwJ/solG8seZ2KWbvyw9fM5rVXNLryDW8CbAaVYDL0yMEUD4v3mlpWvt0DF3ZE
         mtIFQUp2ly7+JEwIJioUMAU4hkCnw2HYJsPFX4drJUtwF9SXgbAy77bxKpFBalw+aqVW
         uUolf6lqSj+G41M2Kfy3E7CkvCQ36YGOzChPSCzkGyKg/hutSCzI7ceya1Hy2LdZKkiv
         ymb3qM/vBA4aj5eB30X/aJ8nXp4hUB8tNfhqVqh0NPbg10ZKYOGSWb9QszwRTJqM6Ov+
         lvIq97L8BCwvh/Tu/GZW3NOmaM74iIlxrTQQchI3myt8GFejPi5HPtr6R/HtKa8+QicJ
         jYIA==
X-Gm-Message-State: AFqh2kqfzBPGN7chmJR/sS13foWbg3lCsKwjC9p5rNksDvoJQudhVPE/
        CafUSq/LSd+83ahccXOsdZaBuOhczw==
X-Google-Smtp-Source: AMrXdXtrg7oHDtv9SxPCh5KjVQ1sS61a1Im9WI3podUMw8xnz+gd6e5kSwNPBftOlHGVhUnnA7PbLw==
X-Received: by 2002:a05:6820:53:b0:4cd:6e9d:993d with SMTP id v19-20020a056820005300b004cd6e9d993dmr5311643oob.2.1672094153219;
        Mon, 26 Dec 2022 14:35:53 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id o129-20020a4a2c87000000b004d1d34f0267sm2245652ooo.40.2022.12.26.14.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:52 -0800 (PST)
Received: (nullmailer pid 83609 invoked by uid 1000);
        Mon, 26 Dec 2022 22:05:24 -0000
Date:   Mon, 26 Dec 2022 16:05:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580
 compatible string
Message-ID: <167209232433.83556.4822446882192587310.robh@kernel.org>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Dec 2022 15:29:23 +0100, Angel Iglesias wrote:
> Add bosch,bmp580 to compatible string for the new family of sensors.
> This family includes the BMP580 and BMP581 sensors. The register map
> in this family presents significant departures from previous generations.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
