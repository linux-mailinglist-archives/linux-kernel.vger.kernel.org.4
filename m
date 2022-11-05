Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D86A61A6E0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKECVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKECVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:21:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242E2F011
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:21:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 02D523200900;
        Fri,  4 Nov 2022 22:21:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 04 Nov 2022 22:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667614885; x=
        1667701285; bh=pkuzyg87KP4rXE017m3xZDHEqWMZVyvOipGLjav84k8=; b=g
        +a1XIb5ASbBT4WOZpReXoq+MxgD2G9T9q4N+mXNxyP8v3qvLwTn06bhqd0YVIPb+
        R3HodEBzFJZyNp4Lp5UMw0y1DvmT0K6df/15/nXIT1GU+f77SpXPLNLucjcfDcSu
        WE8C7HzKQMhgXacU3zkJJM/49W+gYGsTz/CXqe6ntFTr5Smh8Fwfzirt05z1SyFH
        mhSlImNGKOn+JZQBQMFeEi/Ywd9LvsxYZJWVZm0YjbniBdng2Y8cvWYa/slV2lt1
        /bTfMgh2i9dOSo5R6TVqUOsINbzDJ5dRHjckkZSSbcS91CoeCEUVvwnT3iwFRtLC
        JLTa5WdfsVFPghkrbRU0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667614885; x=
        1667701285; bh=pkuzyg87KP4rXE017m3xZDHEqWMZVyvOipGLjav84k8=; b=m
        JZZVdhdYBY88gYVMFETYHw8pMSgyPNkwN3EQoRyJ7FmAVq4zBY+pBSp+gUH7Q86a
        05MlusRleiruNgB+1+6iYcKDl9BurMNh0a/a6oyCB7Icts8JdnOk0ddwLIpv855v
        o0YJadTYRBZp+/fPjoYVQIYhalaNszAMcQmZQ7QrwZZMheFIYhX0aXIwD66r8iKk
        84pMKVco3TETkrf2aqVM1li36PW0xv0iaVAXGJs6RupRnQdxiHEF5QSM+fyEp3bU
        pRnY971ScS9pfa+ADu6zleqFyWsIa6Uv5j00lTrcanAbyaMBfrBSyvsNYQnqx2gh
        o17SmqHzDi4hHEP/d7sFA==
X-ME-Sender: <xms:pchlY7KLT6pXUhf9QxikNI7eTc32poLrKzXxhDCVuYS1THMYPUzE5Q>
    <xme:pchlY_KCbmeP-Ct6hNQhTpCVkdV16niwa83VI7kFzLy5IbwEbxb94NmUPKe3VCXad
    lDVk3RZwOguKG2eQg>
X-ME-Received: <xmr:pchlYzuFK96dhimQpsklpzPN8Xjg3RQIS9EcgNTvjGzbyG5DETrjGy0VwZiSYaqtERFgu99hpkHwv-0ha64jhK7OKl60PJ0MA58qr1frMq41TLw9SkqF2uDNmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pchlY0YogvP04MM-Hq1cGfTkPRAYJLW-TiupnmaZQc8T0EZ1GD2QRQ>
    <xmx:pchlYybOZa8CzETV-RjzmWZhcFVvtows4nzbc0Txrd_q5icDgk9bbg>
    <xmx:pchlY4CGfaXCIoi7s31EN2wbQ8iIpQXvpGhauThEmzaNUng6zFrVug>
    <xmx:pchlY5XffscEUqbAnKQDhCwsWJSkW7jwD1YJ4MpTA7KZx33ZOKM6Lw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 22:21:24 -0400 (EDT)
Message-ID: <214ed3e0-5959-8fa7-8d66-196e33112cb0@sholland.org>
Date:   Fri, 4 Nov 2022 21:21:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, wens@csie.org
Cc:     mripard@kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
References: <9f8a0fc3-1d9a-b271-3c26-4f7373b8a3e9@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [BISECTED] Allwinner A33 tablet does not fully power off
In-Reply-To: <9f8a0fc3-1d9a-b271-3c26-4f7373b8a3e9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivo,

On 10/29/22 10:23, Ivaylo Dimitrov wrote:
> After commit 843107498f91e57d1d4b22cd8787112726fdaeb4 (bus: sunxi-rsb:
> Implement suspend/resume/shutdown callbacks) Q8 A33 tablet I have here
> cannot be powered-on after power-off, it needs press-and-hold of the
> power button for 10 seconds (I guess some HW assisted power down
> happens) before it can be powered-on again.
> 
> The following patch makes it behave correctly:
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 60b082fe2ed0..30016d62044c 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -818,10 +818,7 @@ static int sunxi_rsb_remove(struct platform_device
> *pdev)
> 
>  static void sunxi_rsb_shutdown(struct platform_device *pdev)
>  {
> -       struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
> -
>         pm_runtime_disable(&pdev->dev);
> -       sunxi_rsb_hw_exit(rsb);
>  }
> 
>  static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
> 
> 
> I guess the issue comes from the fact that by the time 'power off'
> command to the power management IC has to be send, the bus it lives on
> is already down, so the device is left in semi-powered down state. Ofc
> this is a wild guess, however, preventing the bus being turned off on
> shutdown fixes the issue.

Your guess is correct. The controller gets shut down in

  kernel_power_off()
    kernel_shutdown_prepare()
      device_shutdown()

but the PMIC communication needs to happen later in

  kernel_power_off()
    machine_power_off()
      pm_power_off()

> Please LMK if the above is the correct approach so I will send a proper
> patch or something else shall be fixed.

Yes, this is exactly the right approach. The whole sunxi_rsb_shutdown()
function should be removed. When you send a patch, please add a Fixes:
tag referencing the commit that you bisected to.

Regards,
Samuel

