Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163C5E5F30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIVKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIVKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:00:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D3A5991;
        Thu, 22 Sep 2022 03:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU4ygtVKYBCJjS54ddQ+GAJuR9R+/VCKpLToOFgdem7qdCi23tZ1CWl6yNa6HjJKd4a7Op2yNuAq3josmci/RH5Z1qeuPTb2krY6fdIOfJHbzXr4luGJFZFVzZJ/oQrc2DE4SuE+Q9sk268JfkFzc4DOp3mlDKZfct1WVjvKm/6hD9LHTR8L3PTmKiPthnP/wmPSoXZN0D8KyCouQDL5d1r1bQtkNdqbV8/1xLcPngEXfhIHvdpZ+7rfN+HSUT8L0MWlBfNJHK8qF8/oPgopWrd3p6FpJiuB60Jkl7MaLYQXp5nkEjAvGO+IgDYLsICPF2AILVVxq5zgFVCro5uEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q62a8rnPsGH+wk/91M2sGgarTvXMo0APlxM7HfzGA90=;
 b=PYa8NGhhwRrUxnFKcXK0vFgejF2XiI2l7N/27zAdMS64DbQAdiH9kbWTJSZEd87lS7nr85yW0RoR4xLtCk/4S8diwwZbjJ8uU8WjmK97qNlPm02as7EIA8X7Ik4DFTcCgtJatjPvz/ohxLF0v8Hx/Ge6xHZ93sS9qLr/B35RKRlTuzXWwmcth3li6e/5CgVUEqYL5ZQjdplxXJNGP634vme30ICACC+oOCpfOnRe6Xqe6wvDqI6W0c6b6/Rm8+lgQp3Pgm6fdUCElLpWYW1L4I4iIMWNcfw7hDGce+GOAn6u1jTBcOQYyP3icER0gkLICGpUvcG/in3HZ6D2R6jGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q62a8rnPsGH+wk/91M2sGgarTvXMo0APlxM7HfzGA90=;
 b=Cj76jVOd7h1wbVlrcS4tWsDNrgjoQwJBpKdMvPw2xIIggd0QkfvTSBQq3LO2W3iVIOd/gXcsTSMUkaSUTB8AK1C7gbgON4mV0GvKsN/0SXOWtM5Oh707YBDm3TYJjW4Ysj+AudHK7A0hiQ54pfY3EF5+ys0dYBlcFEq/VcOEw+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM8PR04MB7879.namprd04.prod.outlook.com (2603:10b6:8:26::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 10:00:43 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4f88:764f:e711:bcff]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4f88:764f:e711:bcff%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 10:00:43 +0000
Date:   Thu, 22 Sep 2022 18:00:36 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: anx7411: Fix build error without
 CONFIG_POWER_SUPPLY
Message-ID: <20220922100036.GA185760@anxtwsw-Precision-3640-Tower>
References: <20220920084431.196258-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920084431.196258-1-renzhijie2@huawei.com>
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR04MB6739:EE_|DM8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d2e10c-7218-498b-e1c3-08da9c814ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBZp0rRyd68RUTTCIY5yn4b7NsIgzZuHS8P9bdZ6QsdWlrnw9tMXc8I6lmDayLEJQIY3V4nwjPAlCK98/OfXHFLkmIWz8NRvGXguCgvqGRyXs4OnuzXy/gsFTqLCyos4gao5o/UbYJkZVww8fomY18wigk9N8Lh6+kzHGt6BBDdheigDRZyjdcHSVRqLVMOPWODpk7yNWFNtBFH1iOLZZwOlBFhXPTM0gDXPiUY8BfpEZfxyAlCCDBjWjMhNuoE/6kfVhFbBUn648roAmFgO+SRzyBrLm1OOsvJhZ1AsOS672sdTOdOyrZWSM8hNaW1mSdVKCzNswl152D7+ehX0sbwMX4EvYuScnnk1zZiI7EnuVQWvS/OsEk7+EJUSjEC/9sor/tUgLarlt+7l0E4fPedGL2mMgzyqFoya6Bv3oFpJfvdvn2K8WXw2xGewAjRKXSglOYiAykHJb31t20EWYQmu5f2lU+1Add97Qssli0gkjBWMME1cxHFwzz5RXFiPqvlaJELjL7Rz/aVW5r+Z9jSx1zPO9AaiQqOp60km3jwPUc8OpPBw3xL0I5S5s25NTTeiXPX3kiEBU7MjR3uPQK3nqRrE8ZgrqrPUijsu1fbo3ATLh0vQbZoYlW7VcGR9/pmluuZIHWTz/385BvGMrV+uYKnEB5JJZa/BmaKuGSlU2PiDErUkW1LIkojIqTyAGASTeu+wgNLbYCiaqVF6dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39840400004)(366004)(376002)(346002)(396003)(451199015)(5660300002)(6916009)(33656002)(8676002)(86362001)(8936002)(41300700001)(4326008)(66476007)(66556008)(66946007)(83380400001)(38100700002)(316002)(1076003)(478600001)(6666004)(52116002)(6506007)(6486002)(186003)(9686003)(33716001)(6512007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/+3j1z5OMydSjwdCsH+EKUWNx0NtEPLSRkhO4DNb8A4HfLs492g+0yRLSg0?=
 =?us-ascii?Q?5YytN5woVBfXw94prkXBOrddMSZKt7GvqwLRtwDoOF0QiMkZUrMDf6sP5AYC?=
 =?us-ascii?Q?oncjOf8PGJmhAdeVnI64Jzu4k+BjIkXGoZ0FboCLzvCiK40VGih0mTZOEHbR?=
 =?us-ascii?Q?spHLLgQ5CAdINQQeOgHPQSmQhfYkQmT1BdN3YtmNxMKAFu9pllmn8oAGw6iw?=
 =?us-ascii?Q?ihbveszpaLGiUIH/2E0aoOFA4DEmpWMbyuI4+sCRA2OhhBjtdwe0jAOMN+iN?=
 =?us-ascii?Q?8MdKeZLSCQFF3BZkTb/RlWI+gFbgKN+BwjU++TSGy8D/vLUoQMkUw8nYZ3VQ?=
 =?us-ascii?Q?6QAyr4yw3DUpjRhYFzvu3UcomMXmvpmpRF6UMWn9lGuJse04uzeeCqOvkSv1?=
 =?us-ascii?Q?62xfy52GhkouHZ3qNmmneWiqxpnNCBOAe2CKzqsDiBsNRgGb9wZLLWIffDc4?=
 =?us-ascii?Q?sVtnjcweUKz41loUCNr8m86Vuc0QU45bixRPUy9Z6weGajm36trXAN0auT4w?=
 =?us-ascii?Q?bE23tp1V6AUzlFoL4TLf/jz7gXtv7i7EiVXx3ctYUJbjcCZ47F+CNkdtGt5Q?=
 =?us-ascii?Q?1le2ZcP6fbBlLspY3eAV+zTIJbmlR73N/tJknM2VuOWyo0ZFYpvVnB1g1Yq/?=
 =?us-ascii?Q?ILEkr7UW0aMcm2kfnt9D73YI8SKoD3fbTABW9TFnUO5iPiHD9UUjhgvSOIpY?=
 =?us-ascii?Q?4sMI+9nr+j3sBxmEQ7iLCbeYjaviPIQxFoNX4lYzu4IWMTNYI0bDZaFav/7G?=
 =?us-ascii?Q?Ln9caHAhitwniPFP2ySYxOowPPOLZkvJc212uY1R5GDdYQR343dA3dRVj4GW?=
 =?us-ascii?Q?Z9d/Gpnd+ZuvwtdgpJkg4/Hx4BsUxrgi9WcPfMX0A0uO3XXDzT4qDJaTzfft?=
 =?us-ascii?Q?PuO1lmfdVE94vhrpzpydSIKXJk/cPAsEih3lMbSTEyBEGEC9Xb5qidoFaGTq?=
 =?us-ascii?Q?b64f8S+2zbURHTuldcEnOCc+1bWQziw4HrxR4P2KEUlivI7Rnh0y/cgBG7D4?=
 =?us-ascii?Q?YRQbOSl4PW95+TcXEY1XVSFLKwbKQOoSAtX4kZowURVTCdnYRDT/GZelv/tG?=
 =?us-ascii?Q?mh/RZ0xJQE/SrYRCVQClpzkwaZsnDeKi5Zk0pXvvHjfO+SlC14/3kF27vw4F?=
 =?us-ascii?Q?kJNA/kCZFgdjimE5zb6CEFf1uqLXD0dy0WfFP+5lpfX6X4/6he9gwS4UMFQ7?=
 =?us-ascii?Q?zn7PHutVSifyTum3DOvwoi5Di1oTaq+UaDxKIAtQ+SB4QyZBbYysySV+Wy71?=
 =?us-ascii?Q?8OYVtachbW12x63box355+LpOzGoNRJ94vKC5HEFiWlPkYgvP/DRrcyGP8j7?=
 =?us-ascii?Q?2mQfOW+4Y9vDDyDtG6IttBWGRMfwiQTNBGMYrNt4sPBeQZVVHopm+YVX6xV+?=
 =?us-ascii?Q?rOXSWOEf6Vnc1GTmMO3/oAAPZjki1hBEY500JgWcuSt8OQFd5RGu7qg898cy?=
 =?us-ascii?Q?3N6hAh1DLE4zrUzbreRyGBg0mhWAwKX4vuc5BuOOcpkC0+xgqqT2+4JDeHtG?=
 =?us-ascii?Q?bwIeBZAHwBhY+yYouND9tkOiCx084+wflDZcCwMFT3vZDheJFt2M8rtGxO+D?=
 =?us-ascii?Q?/v0nRlOMmap/s9BIrdr6/Dv8F9e7v+Bn0Z2w9w8p8XjQEiNfocITDHNs3ZlI?=
 =?us-ascii?Q?ZTEwZDmq4mt4KyFN8XWd1BJncX8Pa27MT2FZyRsnQpJhk7Mpb194pGofsP65?=
 =?us-ascii?Q?w8tW1g=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d2e10c-7218-498b-e1c3-08da9c814ff2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 10:00:43.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYHf2xU16s3jQbZs3ijSUeHAUUFX5efQ9vFioBJ2ALIfMmmXFRBjYMMbzLieqa+rFDJLVC8vuOTxPMnYUh9Fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7879
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 04:44:31PM +0800, Ren Zhijie wrote:
> Building without CONFIG_POWER_SUPPLY will fail:
> 
> drivers/usb/typec/anx7411.o: In function `anx7411_detect_power_mode':
> anx7411.c:(.text+0x527): undefined reference to `power_supply_changed'
> drivers/usb/typec/anx7411.o: In function `anx7411_psy_set_prop':
> anx7411.c:(.text+0x90d): undefined reference to `power_supply_get_drvdata'
> anx7411.c:(.text+0x930): undefined reference to `power_supply_changed'
> drivers/usb/typec/anx7411.o: In function `anx7411_psy_get_prop':
> anx7411.c:(.text+0x94d): undefined reference to `power_supply_get_drvdata'
> drivers/usb/typec/anx7411.o: In function `anx7411_i2c_probe':
> anx7411.c:(.text+0x111d): undefined reference to
> `devm_power_supply_register'
> drivers/usb/typec/anx7411.o: In function `anx7411_work_func':
> anx7411.c:(.text+0x167c): undefined reference to `power_supply_changed'
> anx7411.c:(.text+0x1b55): undefined reference to `power_supply_changed'
> 
> Add POWER_SUPPLY dependency to Kconfig.
Hi Ren Zhijie, thanks for your patch.

Reviewed-by: Xin Ji <xji@analogixsemi.com>
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 5defdfead653..831e7049977d 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -56,6 +56,7 @@ config TYPEC_ANX7411
>  	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
>  	depends on I2C
>  	depends on USB_ROLE_SWITCH
> +	depends on POWER_SUPPLY
>  	help
>  	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
>  	  controller driver.
> -- 
> 2.17.1
