Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BD693017
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBKKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBKKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:47:21 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31291227AD;
        Sat, 11 Feb 2023 02:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676112413; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=g7rRESrRShfpvxtNHCrNrPk+SSm5thXsGPOEXbJUqBW6ajHKov8rsffxCEn6Q86G9UucGAUKUPGTcFCzd2w69iQRZH6CdjuLBF5BfaAUJdgiYk7qS7fm7Bkujs4N2C3n9aS8FjPD0uoaMZr7Sjbx70GnnYqNHsTk4oX4MJBk+c8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676112413; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6cX0mfoiYrBTO9Cv0Oq9v8b6lsLmpUWIcC0kwkgxzZA=; 
        b=J32XNl3TmyO8VuqdD9ingkIFeT+SW/q8Em1r/JPvYdyWbaSq75k5SxhO9Oev2HeGWJP1jhLjhv05U9maQvJYl81M6NPJiNQFiPhFeCXpHG1yZsDlYENHzYt5Fmluu4xw6ItxObG0ZKBREo2UP1893BRK8JM8hOc/dKEaBKc3teY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676112413;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=6cX0mfoiYrBTO9Cv0Oq9v8b6lsLmpUWIcC0kwkgxzZA=;
        b=EGDB/wyfzG5K46ZqHlpFwoJ4BfWfvfeZxKnfMKfA+sP2yt8hrrqrMJ4nFhytEuI3
        KA8I1VAM6pgzOOnS33V/q6IfspbW9mPaCHaVOqNd6Z5TD+uPfYBidA8GVey3sagsyKF
        lRgRjOFCTuK3b+MUAyzGy0/bNE4uSJS91dS00CF0=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676112411376648.2885881165067; Sat, 11 Feb 2023 02:46:51 -0800 (PST)
Message-ID: <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
Date:   Sat, 11 Feb 2023 13:46:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
 <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.2023 13:41, Sergio Paracuellos wrote:
> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>
>> Is this mediatek,sysctl property required after your changes on the
>> watchdog code?
> 
> I don't really understand the question :-) Yes, it is. Since we have
> introduced a new phandle in the watchdog node to be able to access the
> reset status register through the 'sysc' syscon node.
> We need the bindings to be aligned with the mt7621.dtsi file and we
> are getting the syscon regmap handler via
> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.

I believe you need to put mediatek,sysctl under "required:".

Arınç
