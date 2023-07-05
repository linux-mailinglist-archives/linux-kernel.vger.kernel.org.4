Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0C747E98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGEHvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGEHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:51:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375801701;
        Wed,  5 Jul 2023 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688543503; x=1689148303; i=spasswolf@web.de;
 bh=c0ZdzERVZUo8BbU5OZ64jOVKUNGIVCbCmjEIjl533e4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=pRGYCd6qTSy7hoiqmP/UWebMLvpAqH+YKJlUVuAQREP5KIOcaC9/svqJhFTfkDfPVcE6otV
 GqA+zOGTW8I8U1xiFMLAOCHqXe71Z9uF4ffVPOjk0BMIC868OW7OSbWa7Sj+tmRfxIjVBqvxq
 f/yjnMGzJsxd7AuTpp2ZQ2WflW5oHHW8QKcAKJ3+6CQryEAKMJYHiU82UU8XvG7V/7D8fJOhO
 EZPZHOayWMTlQCl9KRPcfRZHmsbuClYsropnUBt/MqqoDLaZbDCVuBVytPm3HEIkHw2wXpwB7
 Uc6nfNv3mHuEsQBU8YzaCd4vds3UEghPd53Iok/1/2uFbtUskopA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1qCoZw1v5X-00EAz8; Wed, 05
 Jul 2023 09:51:43 +0200
Message-ID: <c27953274997a56f8e0522f9331e733ae92bf25b.camel@web.de>
Subject: drm_bridges on fairphone-fp3 are enabled in the wrong order
From:   Bert Karwatzki <spasswolf@web.de>
To:     linux-kernel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 05 Jul 2023 09:51:42 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nIkmF4YOs0B3T9/UEqW3PuJupj40Id5rj6MheFFUcUsLzgpiUpM
 GQf+3XYw9dfUd3yiK0y/IXx4Zcpz3zW8EKcVJYjAjojo595VX87Rb07jKsCYlhY9+KInS8Q
 VM4XtCemnuzgLZtomUuOV+Z5MzwZSAQ9zjoGLOUEMG1XnYoA5yWemi6CPHq8cpddYZlyPG/
 tiOgu5y4VdLQvCVrlN5/w==
UI-OutboundReport: notjunk:1;M01:P0:I3NgqRShjtA=;CuBUUKhbRfogbg7oDxO5LZ+ry7T
 gZXX57BfktCzGiGS12PfhNTo17m9M6UykOWRwVrTfeaaJeT/jlwgxMImR+dwWQ0KniGsU1905
 lQLlChhKlpFIvu2nNhSXUzA5+4ke3ecN/GNZVPdg+DhF0pWE/5M0QJHT6nc8mMAj4tcfrbzJG
 +7S2m/2hDshGR3ldE0DZL0nVmfoJ+inYBUFjrDVbBpfV2yH2KdT+DXnM1elcLOQJmmTTAb/AD
 xrP8Y07unPOtUKJtT8iOmGHrW7YKmHGL7E3cNa40+axP1bVz3mUtUmyFsX9zuy3W5uTb9IJ44
 c9fFCb5nZ9IvsbjcCLQjl5YpsuboVoXM7KLyRIkuWeWbZO12bfJi5NPFc4S3EK8Jb56QVN5FJ
 /ljeW6SzemI3kZFi7FzTtLJrBNVjmCnnSulouE3XYUoYy35LRemlTk0WLDDbnJ6M0MMZkliqa
 VxaD3fE8UsrAzX9qMMdXbLFCi2kS4VHBzv0l74T3VZQlxGhpVxilsRsrOWRRho9TEVrPxHutS
 U6g4JrFZ5sFfELm/HJigUKVorS66PYS2swMQcBbZ1mggNC5c4AlyXrk8OIDpnxiia44DjhV6A
 XeD8FKFh2D/cQ3xzlnXt9j3LTsf6g9j4/ZW/D19w8hmAdvunkGrywJhnO4dV6c+QVSuIblxqe
 x0Z08P1IAra8L1NsWVOlggKx9/+9fE32HlL2Uv9i3a42rRNFv6RP5wAbUtI4kCSq/5LI+WPnK
 lXZnwXV2XKK6hXZSmU9pzqehUoiSGzDRuJuG5iaA3X2jM1Tw6GTO9RF3Zm/1NKXWns6TMbvgG
 7d0WqDlyr9AuLEdKXXU4mXTdlkn4gWoK8CoULiaCJDrGuutm89Iy2llYpWUa7ddR52yhcro25
 aLfZpLmBsHps5HmvYNaEoBovAd26wQWQLuPhX0AGrAZ4zsZxR8W60FxoBoQSC+Q16bYveX5fH
 mtlGGSJIBICzone1EXfmEiUY79M=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fairphone-fp3 has a drm_panel attached to a dsi bridge. This are added=
 to
the bridge_chain in struct drm_encoder in the order dsi, panel. When the
drm_atomic_bridge_chain_pre_enable these get enabled in the order panel, d=
si
because of the list_for_each_entry_reverse. But the drm_panel of the fairp=
hone-
fp3 is enabled using mipi_dsi_dcs_write_buffer which only works if the dsi=
 is
enabled before the panel.
 To work around this one can revert

commit 9e15123eca7942caa8a3e1f58ec0df7d088df149
Author: Douglas Anderson <dianders@chromium.org>
Date:   Tue Jan 31 14:18:25 2023 -0800

    drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset

This leads to a working panel on startup. But when suspending one runs aga=
in
into a similar problem. When the bridges are disabled the dsi is disabled =
first
which leads to a failure in disabling the panel again because
mipi_dsi_dcs_write_buffer fails when the dsi is already switched of.
 As a simple workarund for both problems I have found it works to exchange=
 the
order of the bridge chain in drm_endcoder:

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c
b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 28b8012a21f2..990f7c68a27c 100644
=2D-- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -550,6 +555,8 @@ int msm_dsi_manager_ext_bridge_init(u8 id)
 		if (ret < 0)
 			return ret;
 	}
+	/* swap bridges in list */
+	list_swap(&encoder->bridge_chain, encoder->bridge_chain.next);

 	/* The pipeline is ready, ping encoders if necessary */
 	msm_dsi_manager_set_split_display(id);

But this does not look like a portable solution so I wonder if there is a =
better
way to do this.

The linux kernel used here is a linux-next-20220630, with several out-of-t=
ree
patches which are needed for the msm8953 gpu and the display used in the
fairphone-fp3 located here: https://github.com/spasswolf/msm8953-linux.git=
 in
branch msm8953_iommu_rebase_v2_wlan_modem_ipa_cpufreq_display_debug.

Bert Karwatzki
