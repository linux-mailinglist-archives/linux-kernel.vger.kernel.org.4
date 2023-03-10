Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677646B5151
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCJUB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCJUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:01:15 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE312D410;
        Fri, 10 Mar 2023 12:01:05 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MILru-1pp4O11Xue-00EPAk; Fri, 10 Mar 2023 21:00:45 +0100
Message-ID: <a61562c7-f064-9d4d-961d-12e3f29c9f5e@i2se.com>
Date:   Fri, 10 Mar 2023 21:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230310164523.534571-1-o.rempel@pengutronix.de>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230310164523.534571-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K4OSnDxed7xJFPDbaQDMyReZN+rcplt8amszQzVsF7kkqIwO2Yk
 hf4CqPmjtsEGJmI0zDklnPx1Rbhh7vT09WjSdCqApmT22DbFY6dvtZW9kavQ/6MnfKxb7fM
 nNhaz4Z7//CdwW/l9CDxvmxu8jewfIysMCFQq1qjNzTRNs0tPDpuH8FaETLWHB9qS+iucCo
 lv2CZ51HoUttvX8oiEA4g==
UI-OutboundReport: notjunk:1;M01:P0:8dkClVkVP4I=;3c917G4NR0QA/cp7oKckL/CioGR
 UE3H4CrgX/c6oNHM1x58CX7sCAG2/PtlELn4BMUrkJfQXxopXfkVy3tA0GN2yJ1lXz6BgHCUo
 O9s0s3UPmW3731HptfbyR3KJBGNjoOvhgatDLTKS13Ak5co1vPbSE+1l+iYNYGyjznxAwVmjX
 gY9XUafbxdcWMwi7PCeGM/EFqvgb32pnSLvi9jKszHrUHtit+vBD+OSRwDzoWy8ioPAvvW9wv
 LEOZWgiW9ZkvkC0WlMwKB6PasHXaDd+V1qMONShcfcutX2oWWXOS12uu6uCkm2vzGlLpX/vI3
 /P3nuURh7oFzTqYIn+1k9uig1Q6zmHYaJ3HlMTlm2v6OI1y86zHg0f72uOwZ8868ZFecCikOB
 A6erq8oOxCUuBAHY+yqqF1GzqMUlbw+io+lN4TAUUI0r6NGkalLY0SRWTZMorNbvz/tOLT700
 XBuQt2qp5kapFnEpMhxcq0to5Mw3Gj9CMPmRF75+ON4HdlZg8swYcUlzbB2fXmkATOZeM2Gjz
 pFD5yShUWQdH7QwyUPRRoaLA8DYRdpryzbj4BZ0oNF3bueRN+/VuFXQmTundJzy3/D0nZU1lz
 tTLcHcT71ZiiMMpQ05NZD4ZlbZ8Hck3BzTQ8V4DoBBCUo3Q+jODF8d/r1Clq3i5vbo/P8Os8P
 6vzswekxeU5WV0zREKGAMIl4HYP25l46zXjq5vh2Yg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.03.23 um 17:45 schrieb Oleksij Rempel:
> On some configuration we may get following error:
> [    0.000000] imx:clk-gpr-mux: failed to get parent (-EINVAL)
>
> This happens if selector is configured to not supported value. To avoid
> this warnings add dummy parents for not supported values.
>
> Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

