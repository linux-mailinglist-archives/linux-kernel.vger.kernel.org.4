Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D660E3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiJZPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJZPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:00:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434DF2BB22;
        Wed, 26 Oct 2022 08:00:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r187so1912610oia.8;
        Wed, 26 Oct 2022 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txXT/wKuP7e6vmu341lu5ocYQu6nOYOzPylEPZrz0ao=;
        b=eUKReRdPe5/6Wf1hvfzbtzHbxaDKbWabbo7VhS5Mw0W4Oyb7vlrOoUuM1n4Ccjs41i
         CnEVqPzAY3qS/QzZgNB9cilk2SC2d1QODWsOijmjWRqKtPEhBVJHlCT/madDQQ/Njsil
         OC4yvePxJKytlrH/4z8aN62RcP556W9jOz7sedI12lhEvtPRE+9F1qmwjTj3bRj6pCfT
         oV7UrOISfNJUtn74TjL/bBnq/8o5/KamvzmV+5yG0vtb/sfcBoBnmDjoZ9safWks4SsL
         rUBPIGatBcJx3vffkAFxWztkVN4RD1PutoreQEZxIqwIJ/qD/B580LX8JaSjBRuRCEuA
         EKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txXT/wKuP7e6vmu341lu5ocYQu6nOYOzPylEPZrz0ao=;
        b=SKBFJVpFug8/jZN9KAcS2bvYfdcqWuAownP1Y7m7DQ9ixV3HPHTbm1MQkf4CqoD10b
         AeRHUmMVX2V+7ya5W9+UP3cMRWFDbsLtyxWuBSx05i7Ek7HcslKUT+tNwcXdsEOlWt4m
         Ja/9jDiWoZle7+nqv3MTkXpcxYGlgxxVlsOdNn+CFyPHDTh6goIQolXdIk0FVsyccU0Z
         Qf0qdJ3K/ajU8/Pjz2UYVbri9ZG2m/Up0Ql41ZLaQj0Q7vUvrnvEVWncV/Ag9KRJwFYl
         ZSnYWUZwkHXnsO9MCeHbPHTQpN0olA9NpzFROkQSnjW4pcL1Da/BiajE8FeQ4OkuGuic
         FGVA==
X-Gm-Message-State: ACrzQf12ugGpx6EXA3yZBhBxa/8HDYidFttHwpLdeM+5rcKho3EmwVyD
        6EnpJzMjgC0AL5t+vJVTcL8=
X-Google-Smtp-Source: AMsMyM7Boz8EiNGrugjMh/1o3LveBg7F50E5TXO7Q+5hoDFb4+nzDkAPU6DBuPcT107b8EUDsqUkQA==
X-Received: by 2002:a05:6808:23d4:b0:354:e81a:12a8 with SMTP id bq20-20020a05680823d400b00354e81a12a8mr2083674oib.78.1666796403179;
        Wed, 26 Oct 2022 08:00:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w110-20020a9d3677000000b0066227572ee3sm2265814otb.52.2022.10.26.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:00:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Oct 2022 08:00:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Lee Jones <lee@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 1/9] hwmon: smpro: Add Ampere's Altra smpro-hwmon
 driver
Message-ID: <20221026150001.GA2545504@roeck-us.net>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-2-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:43:13PM +0700, Quan Nguyen wrote:
> This commit adds support for Ampere SMpro hwmon driver. This driver
> supports accessing various CPU sensors provided by the SMpro co-processor
> including temperature, power, voltages, and current.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I see that the mfd patch was accepted into the mfd subsystem,
so I'll apply this and the next patch in the series to hwmon-next.

Thanks,
Guenter
