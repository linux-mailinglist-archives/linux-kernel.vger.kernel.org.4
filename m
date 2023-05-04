Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFF6F65E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEDHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEDHg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:36:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E83A81
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:36:17 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1puTVQ-0002EA-IB; Thu, 04 May 2023 09:36:00 +0200
Message-ID: <a45ac6da-8e29-9b2d-6172-8bc043afc415@pengutronix.de>
Date:   Thu, 4 May 2023 09:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: support non-default
 data-mapping
Content-Language: en-US, de-DE
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, daniel@ffwll.ch, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        airlied@gmail.com, kernel@pengutronix.de,
        patchwork-jzi@pengutronix.de
References: <20230414161116.3673911-1-j.zink@pengutronix.de>
 <20230414161116.3673911-2-j.zink@pengutronix.de>
 <20230418212058.GA2351633-robh@kernel.org>
 <b4cb0a91-26f9-94d6-4bde-87cfc9ba2a47@pengutronix.de>
In-Reply-To: <b4cb0a91-26f9-94d6-4bde-87cfc9ba2a47@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/19/23 08:29, Johannes Zink wrote:
[snip]


>>
>> Why do you duplicate what's in display/lvds.yaml?
> 
> I don't think any of the other properties from display/lvds.yaml 
> currently make any sense to be put into simple-panel, thus I selectively 
> picked this one.
> 
> If there is a way to selectively pick only the data_mapping, please let 
> me know and I send a V2
> 
>>
>> This also just made 'data-mapping' valid on non-LVDS panels.
> 
> what is the canonical way of restricting the data-mapping property to 
> LVDS panels only? Or ist the proper way to go to move the panel I use 
> (innolux,g101ice-l01) to its own yaml file, include panel-simple.yaml 
> and leave the others alone? I think other LVDS panels might benefit from 
> this series though, which is why I think it makes sense to add the 
> property to all LVDS panels.
> 

gentle ping. How do you suggest should I proceed here? Maybe pulling the 
data-mapping definition in a separate file and include it in both files?

Can I enable the property selectively, e.g. only on the 
innolux,g101ice-l01 panel, in order not to enable it on non-LVDS panels 
or on LVDS-panels which might not support it?

Best regards
Johannes

[snip]
-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

