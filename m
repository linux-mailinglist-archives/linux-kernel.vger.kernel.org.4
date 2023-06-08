Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F787727FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjFHMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjFHMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:17:11 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565826B9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:17:09 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ADAD624E21A;
        Thu,  8 Jun 2023 20:17:03 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Jun
 2023 20:17:03 +0800
Received: from [192.168.125.124] (183.27.98.122) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Jun
 2023 20:17:03 +0800
Message-ID: <1eab400c-b568-3042-ebb6-e8244dee0149@starfivetech.com>
Date:   Thu, 8 Jun 2023 20:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1] ASoC: starfive: Cleanup and fix error check for JH7110
 TDM
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
 <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
 <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
 <fbbc0963-fba5-4178-b886-fbb35c0c8df2@sirena.org.uk>
 <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
 <c974d0c7-b091-4d5c-b73c-1b6584eb823a@sirena.org.uk>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <c974d0c7-b091-4d5c-b73c-1b6584eb823a@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.122]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/8 18:50, Mark Brown wrote:
> On Thu, Jun 08, 2023 at 06:43:09PM +0800, Walker Chen wrote:
>> On 2023/6/8 18:15, Mark Brown wrote:
> 
>> > I can't find the comments you're referring to in there.
> 
>> You should see the following comments in the link above:
> 
>> > +       #define CLKPOL_BIT              5
>> > +       #define TRITXEN_BIT             4
>> > +       #define ELM_BIT                 3
>> > +       #define SYNCM_BIT               2
>> > +       #define MS_BIT                  1
> 
>> Instead of these *_BIT defines as plain numbers you can defined them using
>> BIT() macro and use macros in place instead of
> 
> The usual pattern is to have defines for both the shift and the mask,
> not just one.

OK, I see. It's not necessary to make these changes.
Thanks.

Best regards,
Walker
