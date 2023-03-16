Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBC6BDA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCPUej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCPUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:34:35 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF426C3C;
        Thu, 16 Mar 2023 13:34:21 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id s4so1359186ioj.11;
        Thu, 16 Mar 2023 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678998860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CYbM47sU5ai4TXEql000Ah99D8S1/cVmeQxmiAsqhs=;
        b=d6o8KRbRGgUKwJryRq6B7MVsOiSXjD6THITo3k0KK0P7oVyv+Cutma5r1IegYxBaRV
         SFQcOSYUVYO4G+oxCeq8kl51+PkDPOD0ibd0BKNthpKM2oRokUIKqYQMMV6bq9oMDzIJ
         uwn0FMhfhVD+n1r1Fe4d5FCdL1BSkHGQvZ4pqtuQA4Qi8DRlVJydwfutB4F6LDP9v5Ly
         JN3ss3JvzOXX3PcfT5xN2uzpu6AZfN5HXSiZO3Pwi8OsvjtBdjTu0O/3LbdbEI7weYsL
         jXQRNfwA8/1ULtr3Mi2uW/D0w1SKqsCcE0Rb1NUg2fYDH5FnnkzNThQN175KrQNTOncN
         cfMw==
X-Gm-Message-State: AO0yUKUIy+SHWERcwduhCdAb+g9/cGm8OuRjo3k42C+nTr/g3PL5PG/g
        Dlv0smXUiQJrVRs0LkuNdQ==
X-Google-Smtp-Source: AK7set95htVCepu2fkqTuH63ymkWubjwHz01woOvMx5gt6cqqYiqMELyvuyd4SP0vC6lmQKNMoI68A==
X-Received: by 2002:a5d:980e:0:b0:74c:8b56:42bb with SMTP id a14-20020a5d980e000000b0074c8b5642bbmr102686iol.8.1678998860080;
        Thu, 16 Mar 2023 13:34:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q15-20020a6bf20f000000b00704608527d1sm43269ioh.37.2023.03.16.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:34:19 -0700 (PDT)
Received: (nullmailer pid 3837822 invoked by uid 1000);
        Thu, 16 Mar 2023 20:34:17 -0000
Date:   Thu, 16 Mar 2023 15:34:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 01/11] dt-bindings: firmware: arm,scmi: Document
 assigned-clocks and assigned-clock-rates
Message-ID: <20230316203417.GA3833267-robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315114806.3819515-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Stephen

On Wed, Mar 15, 2023 at 01:47:56PM +0200, Cristian Ciocaltea wrote:
> Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
> protocol child node properties") the following dtbs_check warning is
> shown:
> 
>   rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are not allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)

I think that's a somewhat questionable use of assigned-clock-rates. It 
should be located with the consumer rather than the provider IMO. The 
consumers of those 2 clocks are the CPU nodes.

Rob
