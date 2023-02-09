Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D81690C65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBIPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBIPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:06:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF73A0;
        Thu,  9 Feb 2023 07:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FAB6B82186;
        Thu,  9 Feb 2023 15:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA404C43443;
        Thu,  9 Feb 2023 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675955199;
        bh=YzH3oVoNE1CjwPcE3PjI1A0MAUIcY7ST9R5Q0/Ug9Dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r7G1O3UjQ2cuOkEmjpThjB9EndPzQzUWeS4crAhbGCwKu9JkoPLJAxaRo8BOQSu4H
         Wu9oOkHY3VMJiww8tV3f/Y95XuvnylF2rUD1O0bLX4o7dHgymHJaXJ3qLnQSLVFSmD
         lTHnl3CSxaYfTI1xADtmO/Q/E4FiBd0Pa9Ne0fHU6uNBME0vYLbQPKIIKvuRrHRfG5
         6tTARHmyZkA4WMG+tJXjDCYvLnvFrrKrQ3TpuNLIEhjCKGxjkbaRa3KzxvLf9CtCda
         rV61BZhx1pUwWjgohItlUYs5I/pOtBL5ELfJvDVCoEf/+F+qNcfgoBH9fhu56wU11b
         VOtSM6Mnsfh8w==
Received: by mail-vs1-f49.google.com with SMTP id l8so2378896vsm.11;
        Thu, 09 Feb 2023 07:06:39 -0800 (PST)
X-Gm-Message-State: AO0yUKX7aH+AXQoAMfoR7LhxhOcg/0K9322fxEtnx81z2oZOqJ1vCJpN
        ul0jACVq3noTBTLPHk8PgsDcUCa1oxo8WEnjGA==
X-Google-Smtp-Source: AK7set8xITZUTZ7JTnJX/T1dUh1NB+jPvj8WgukL1xX/D/0q7BYlqVwEIJC1MmlL4EbavNkjzHZN/z55yic1gqQHloI=
X-Received: by 2002:a05:6102:2ea:b0:411:b8c5:973a with SMTP id
 j10-20020a05610202ea00b00411b8c5973amr1374534vsj.0.1675955198667; Thu, 09 Feb
 2023 07:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20230128133151.29471-1-henrik@grimler.se> <20230128133151.29471-3-henrik@grimler.se>
In-Reply-To: <20230128133151.29471-3-henrik@grimler.se>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Feb 2023 09:06:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+y2_aHXsxj4sx0KPATDi9-7mujruowpbq2kxro4e13zg@mail.gmail.com>
Message-ID: <CAL_Jsq+y2_aHXsxj4sx0KPATDi9-7mujruowpbq2kxro4e13zg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
To:     Henrik Grimler <henrik@grimler.se>
Cc:     krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 7:32 AM Henrik Grimler <henrik@grimler.se> wrote:
>
> Add aliases for eMMC, SD card and WiFi where applicable, so that
> assigned mmcblk numbers are always the same.

What does WiFi have to do with mmcblk?
