Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F116BD64C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCPQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCPQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:51:44 -0400
X-Greylist: delayed 1414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 09:51:41 PDT
Received: from 5.mo581.mail-out.ovh.net (5.mo581.mail-out.ovh.net [178.32.120.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD6B1EFF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:51:41 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.156.25])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 1FFEF26191
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:28:05 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-86shx (unknown [10.110.208.248])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8159C1FDB2;
        Thu, 16 Mar 2023 16:28:04 +0000 (UTC)
Received: from RCM-web5.webmail.mail.ovh.net ([51.255.71.60])
        by ghost-submission-6684bf9d7b-86shx with ESMTPSA
        id 5FlvHpRDE2QaIAEAW/RUIA
        (envelope-from <rafal@milecki.pl>); Thu, 16 Mar 2023 16:28:04 +0000
MIME-Version: 1.0
Date:   Thu, 16 Mar 2023 17:28:04 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] nvmem: Add macro to register nvmem layout drivers
In-Reply-To: <20230315100018.1660071-2-miquel.raynal@bootlin.com>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
 <20230315100018.1660071-2-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5d3d01ec1b05ec47c0590d5af14c4f37@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4869798574140337136
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeetheelfefgjedutdeivdduvdethffhhedulefggeeitdejudfhkeetjeekieejgfenucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpdehuddrvdehhedrjedurdeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 11:00, Miquel Raynal wrote:
> Provide a module_nvmem_layout_driver() macro at the end of the
> nvmem-provider.h header to reduce the boilerplate when registering 
> nvmem
> layout drivers.

I think you should take care of including <linux/device/driver.h>
instead of depending on module_nvmem_layout_driver() *callers* to do
that.

That would help avoiding errors like:

In file included from drivers/nvmem/layouts/fixed.c:5:
./include/linux/nvmem-provider.h:252:2: warning: data definition has no 
type or storage class
   252 |  module_driver(__layout_driver, nvmem_layout_register, \
       |  ^~~~~~~~~~~~~
./include/linux/nvmem-provider.h:252:2: error: type defaults to 'int' in 
declaration of 'module_driver' [-Werror=implicit-int]
   252 |  module_driver(__layout_driver, nvmem_layout_register, \
       |  ^~~~~~~~~~~~~


> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/nvmem-provider.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/nvmem-provider.h 
> b/include/linux/nvmem-provider.h
> index 0cf9f9490514..a1c668018894 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -240,4 +240,9 @@ nvmem_layout_get_match_data(struct nvmem_device 
> *nvmem,
>  }
> 
>  #endif /* CONFIG_NVMEM */
> +
> +#define module_nvmem_layout_driver(__layout_driver)		\
> +	module_driver(__layout_driver, nvmem_layout_register,	\
> +		      nvmem_layout_unregister)
> +
>  #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
