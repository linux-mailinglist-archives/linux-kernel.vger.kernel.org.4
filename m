Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62F45BCCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiISNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiISNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:18:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4424082;
        Mon, 19 Sep 2022 06:18:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fs14so27807798pjb.5;
        Mon, 19 Sep 2022 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=G5PIQAim5D/NGZ1Hfe4AxnReb1kPVNN7aiFtqcVOFts=;
        b=JI//1M4tK3EtoIgkARNb77ijPKU7BETT+Z+Zf4xaqK0aOzOyL8QGMgez4cc4s5EzNG
         AmPR3yZV0ER71nH5d6HmxCKOVgBAuCBKWPVBq0tPWpZ0ANlSN44aw/5poVCsmD1oYv72
         DZfpHaZ4xNldTsyft7LDxfBY2kjoYkdOs44NAxdeV/Ngj99UP0nqscfq89Wzxl6OBX/g
         a68YGfbQHjkp7Z7JeOO6zhKsq97RUu4NAAF6kYVcSdoxYEFsfXDNURTb+bXNqmTq0Cvi
         cY+9D+VztKeKhgIH9k9DpC3wY6XxRX/Lb1g7ni30C0z693vQ29avszhB76rKbrZEpo/x
         osXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G5PIQAim5D/NGZ1Hfe4AxnReb1kPVNN7aiFtqcVOFts=;
        b=redEdwUcOb2LOP1RUEgixayguE8L9oDJdUs6HcDgIgqYbOpHa0agCZScr1/6gdAfpM
         BsYl/peENUen04NGhEIyN0fkyHYb4icFikQ51pj3CrSoKg+R3Z4QtrLrS17LJn1hDPY/
         aFAbRaeDDFA/tncOve5DKEWs4O9wtPWFVYp4zypb48L7kFCnXfjFr5dBh169xkwceTDj
         HDninFwqcSpnfcykpYCh/v1K+e1s10abTf6VLVB7z03Rr3LR41vc1ZAqHYVkdE2kOIjM
         blG8VXKGnQ4kUMlldAQLYHZN3SUg0MNc5E6d3kbkLWwtrz4VA2CeJuD1Yqz7Ato62uYC
         62Ug==
X-Gm-Message-State: ACrzQf1cO2CqP++FICfEygTv61RtLUeIJyIoIQg8fcklud2z1NtPd3Mc
        BqHaQxjRwmdB5ljeu7sU3Ds=
X-Google-Smtp-Source: AMsMyM5D6K7xXJi89SdzXmJep5uZFcYUH297ecSp2h7WYUdyo6NNgw6/J7zE4aF+owPSDnYnKkInIg==
X-Received: by 2002:a17:90b:350a:b0:200:a7b4:64f7 with SMTP id ls10-20020a17090b350a00b00200a7b464f7mr31347346pjb.113.1663593494354;
        Mon, 19 Sep 2022 06:18:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902a38f00b001785dddc703sm11554321pla.120.2022.09.19.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:18:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:18:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add
 "moortec,ts-series" property
Message-ID: <20220919131812.GA3547013@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-17-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-17-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:44PM +0000, Eliav Farber wrote:
> Add optional "moortec,ts-series" property to define the temperature
> equation and coefficients that shall be used to convert the digital
> output to value in milli-Celsius.
> Supported series: 5 (default) and 6.
> 
> Series 5:
>   T = G + H * (n / cal5 - 0.5) + J * F
> Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
> 
> Series 6:
>    T = G + H * (n / cal5 - 0.5)
> Where: G = 57.4, H = 249.4, cal5 = 4096
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
