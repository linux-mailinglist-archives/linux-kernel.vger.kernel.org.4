Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B034961FAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiKGQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiKGQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:55:47 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792011F2E4;
        Mon,  7 Nov 2022 08:55:46 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id t62so12738039oib.12;
        Mon, 07 Nov 2022 08:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPM1SjQy3RL278fadljq6LXWFkiGCqCWW45rr2YCC9k=;
        b=DgKMAfp8GhV1+ehpI4L3JuSZkl47DNDM8BdUd321ATnxOhzTqZwUoDNCptjzlK7kkb
         mVn4Ja8QQdrxxGOzBj+/oqJbHsHPiIE2NVCU9TR3OcMC9Tj8d35VDnovIAZSL8x6bE9C
         qOQSAI+R0D7HMZiqDsTTf1wca52tu2ZzBoZ6gzdRm4cY/3TtA2wOh7LOy4AyDiFr0mXI
         KbqeXlib19ufrunpLQk3P7VvcT4IZuOSYT2tzowJx/zPwYq8zl1tOEgtwiAVxnVbcNbe
         Mir0bPKCqJI2QFNC/F4WW7jWryW9tnEHI8SLJ3TubSrIxWJDLOFY9PBMVtWlRM4oHpF0
         /PjA==
X-Gm-Message-State: ACrzQf1ozVEugo0VYzRn+zjjafDE5akmtOs8yn57g9/cTeOkVH66UH2o
        OGSG+OnBRaGTcIONZiLBog==
X-Google-Smtp-Source: AMsMyM4KGfE4d7WEoO1UV7x/0XyV0YFT5iUy6Ik/q+LODSTg6VDGMqLqNxPdr/1UYIHozMuxxxbHHQ==
X-Received: by 2002:a05:6808:1446:b0:35a:e73:5c39 with SMTP id x6-20020a056808144600b0035a0e735c39mr23179455oiv.113.1667840145674;
        Mon, 07 Nov 2022 08:55:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v194-20020acaaccb000000b00359a9663053sm2591795oie.4.2022.11.07.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:55:45 -0800 (PST)
Received: (nullmailer pid 1233957 invoked by uid 1000);
        Mon, 07 Nov 2022 16:55:47 -0000
Date:   Mon, 7 Nov 2022 10:55:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 07/13] dt-bindings: iio: temperature: ltc2983: require
 4 wire rtd for current rotate
Message-ID: <166784014532.1233860.9945084029419885067.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-8-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-8-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 15:00:35 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The driver will error out when current rotation is enabled but the RTD
> is not 4-wire. Require it in the binding too.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 25 +++++++++++--------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
