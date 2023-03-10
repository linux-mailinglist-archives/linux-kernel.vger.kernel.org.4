Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAAA6B3886
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCJIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCJIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:25:50 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 00:25:49 PST
Received: from bitmer.com (server-237-49.tentacle.cloud [185.179.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B931070E1;
        Fri, 10 Mar 2023 00:25:48 -0800 (PST)
Received: from jarkko by bitmer.com with local (Exim 4.92)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1paWpw-0003gh-Gf; Fri, 10 Mar 2023 09:06:44 +0200
Date:   Fri, 10 Mar 2023 09:06:44 +0200
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, oder_chiou@realtek.com,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        matthias.bgg@gmail.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, vkoul@kernel.org, daniel.baluta@nxp.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] ASoC: do not include pm_runtime.h if not used
Message-ID: <20230310070644.GA13582@bitmer.com>
References: <20230307103022.1007420-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307103022.1007420-1-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 12:30:22PM +0200, Claudiu Beznea wrote:
> Do not include pm_runtime.h header in files where runtime PM support is
> not implemented.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
...
>  sound/soc/ti/omap-mcbsp-st.c                              | 1 -
>  36 files changed, 37 deletions(-)

Looks like header was copied by accident from omap-mcbsp.c when sidetone
functionality was split into this new file.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
