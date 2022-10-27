Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2560FADB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiJ0Owv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiJ0Owi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:52:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB706EA9C9;
        Thu, 27 Oct 2022 07:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97AC1CE26F0;
        Thu, 27 Oct 2022 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D51C433D6;
        Thu, 27 Oct 2022 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666882351;
        bh=jTEEOUklXetex1TUo5omUcT3p8eJ5Vnvb1qhgEzzmLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s95szTrBhoPCZR557GQy/SDo7RemHuo0Alzlr/HYI4osEu4I/5ieQl5QXRqJZjMuC
         6y+RxV2C9CKCDnGmxv3WhTcQn9Cbsd9qd7BUP50nlOGfX0/useWRCUMPPKOWXdtpz+
         /445Hxzrkg7AbLYQFw8zRMJFrWIjZv0nRizv0vbMixP1LjbKDEGucjslQG3zgepEVX
         pbVpE4Kqw4tJBrVZLojVb7eMrn7zvwnJ6TQF4yQpt1NlHJ5JtCdTd2pomuHexheXO6
         EN2nQA/5HqfzM7HCRmLftTyh0Mxp7pD+pk/B8m3SYbaaTkwMFfsCtKnvJWXsJASuvw
         lJpnI3CPFzpiw==
Message-ID: <9e64a359-68f5-51b0-bc14-6eda57e41774@kernel.org>
Date:   Thu, 27 Oct 2022 10:52:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        =?UTF-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
 <20221026063327.20037-2-Runyang.Chen@mediatek.com>
 <20221026152645.GA2946818@roeck-us.net>
 <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
 <5abd63240a7890895a6de26a52fc24086f1c8ddb.camel@mediatek.com>
 <e6035c60-29b7-a03e-29cd-77c37f5375e6@roeck-us.net>
 <c42c4fff91a0794ff0514880182564d28026297a.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c42c4fff91a0794ff0514880182564d28026297a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 09:54, Allen-KH Cheng (程冠勳) wrote:
>> You did not copy the watchdog mailing list with this patch, causing
>> it to get lost
>> from my queue (even though I had a look at it). If there were other
>> watchdog related
>> patches in this version of the series, they got lost as well.
>>
>> Guenter
>>
> 
> I apologize for missing this and will pay attention next time (v3).
> 

Just use get_maintainers.pl and automate your task... Automation removes
(most) mistakes.

Best regards,
Krzysztof

