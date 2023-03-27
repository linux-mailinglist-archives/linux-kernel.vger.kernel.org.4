Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFFB6C9BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjC0HQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjC0HQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:16:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A149CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:16:51 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pgh5o-0006Z6-Fv; Mon, 27 Mar 2023 09:16:36 +0200
Message-ID: <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
Date:   Mon, 27 Mar 2023 09:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Content-Language: en-US
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     peng.fan@nxp.com, laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        abelvesa@kernel.org, marex@denx.de, Markus.Niebel@ew.tq-group.com,
        paul.elder@ideasonboard.com, gerg@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        djakov@kernel.org, l.stach@pengutronix.de, shawnguo@kernel.org,
        abailon@baylibre.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org> <2678294.mvXUDI8C0e@steina-w>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <2678294.mvXUDI8C0e@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 27.03.23 08:27, Alexander Stein wrote:
> Am Montag, 27. März 2023, 06:50:37 CEST schrieb Greg Ungerer:
>> Any thoughts on why this breaks USB?
> 
> Maybe you are missing CONFIG_INTERCONNECT_IMX8MP?

And if that's the case, did you check /sys/kernel/debug/devices_deferred
to see if there was any indication that this is the reason?

If you didn't find any hint there, you might want to place a
dev_err_probe with a suitable message at the place where -EPROBE_DEFER
was returned.

Cheers,
Ahmad

> 
> Best regards,
> Alexander
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

