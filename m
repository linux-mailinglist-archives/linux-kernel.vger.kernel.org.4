Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E65743917
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjF3KLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjF3KL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:11:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E11FE7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:11:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f766777605so2694118e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688119887; x=1690711887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BFlfbAIfoDlnMUceOo+cEC26pgciEbyD8McQYGYoy0=;
        b=U3e2f+aVKn74qcFA9TjZ5GPgcDNPKp04o7E2EJ/PScAt5JDpMuxteBQsSdxxPab8g1
         fiBkdu3NllhwoBnxeQsCQk79/bxOzxWsamlKuCt6NEePCUmljoyAyzYjMapGCPA+Lnjo
         EH73XvElbVyB0iKqnj46NFFwFg1AJZyA/Ve/EONDmQnnqm4WtId7Xw0OoSnYzKbDqeCm
         AZ0W2tR+BFMxACXes2qJCIHIjoivKsa9HaLfcMvYTgaOj2DPoe3zISnm7MDJMMOzvozV
         geIc4j3TffAsF7W/7bN/fhzvZPpG2YxOXw4OJ03oGtHUSGqem9tdDF7/eoCahgQWnnO3
         f+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688119887; x=1690711887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BFlfbAIfoDlnMUceOo+cEC26pgciEbyD8McQYGYoy0=;
        b=TvWwR0q3rmYZU82+/xl8u+I8aXO7ca0LSHAWqkrQUPu8VyhWyam6YYaeiwDQR9yioO
         9cwiVqIF5J07KKvu4Yt4x4iE/4ub4NlxXx1Vtmq7QTWIokjQRZ8pSaYA0gmxqmovcip/
         0eCn8XUR6WZpQi3XlpJvyBzi5CWYWjceAuVBgTd8u7NYYh6ps8UAgbz8+96BQgCPJkEb
         XDXummrHiieXW1s96HzHcxPOls/HFRivcLsO/aYGWKNwvNkhnqMuyUAl025zV4OuCNLK
         4WGfqgkrkzitRinjyDUCF1M+ZHSKuVr769s7Oyfp+QGRF7Ot8t1ypNDGrF5Ed/tZweV5
         btdw==
X-Gm-Message-State: ABy/qLZDP4V2OmMGwQTVEjbY4N3z1su8ZAqCNLWkwRDkvwN5DffzjVIE
        tds55Onji6gS90CQhfDsWuBr+g==
X-Google-Smtp-Source: APBJJlGnhWJ4b9VxEgxH1ES2aQkjiqmgJhB9RNzeKyXcqPp/Vv6GLW4EAwOh/lUJ173h512qaK8yiA==
X-Received: by 2002:a19:910a:0:b0:4f8:7568:e953 with SMTP id t10-20020a19910a000000b004f87568e953mr1720528lfd.35.1688119886617;
        Fri, 30 Jun 2023 03:11:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m8-20020adffe48000000b002c71b4d476asm18041198wrs.106.2023.06.30.03.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 03:11:26 -0700 (PDT)
Message-ID: <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
Date:   Fri, 30 Jun 2023 12:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 30/06/2023 10:16, Rafael J. Wysocki wrote:
> On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:

[ ... ]

> So what about adding a new zone attribute that can be used to specify
> the preferred caching time for the temperature?
> 
> That is, if the time interval between two consecutive updates of the
> cached temperature value is less than the value of the new attribute,
> the cached temperature value will be returned by "temp".  Otherwise,
> it will cause the sensor to be read and the value obtained from it
> will be returned to user space and cached.
> 
> If the value of the new attribute is 0, everything will work as it
> does now (which will also need to be the default behavior).

I'm still not convinced about the feature.

Eduardo provided some numbers but they seem based on the characteristics 
of the I2C, not to a real use case. Eduardo?

Before adding more complexity in the thermal framework and yet another 
sysfs entry, it would be interesting to have an experiment and show the 
impact of both configurations, not from a timing point of view but with 
a temperature mitigation accuracy.

Without a real use case, this feature does make really sense IMO.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

