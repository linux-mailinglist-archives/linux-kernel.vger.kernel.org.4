Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B804665BE7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbjACK4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjACK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:56:37 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251B287;
        Tue,  3 Jan 2023 02:56:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBvhtm+nJBR5kyWKWBhIB8Cd9znua/3VzW1Np8HzEr9dquZjsfIT9vypV7kJVF10ID6uSze0jYnIRqrKnSlakcxrefshrt1tJ3aLdTuwDZ6C5B9SRgDfJ9RZyfxSpobc1n8lsfIIwY+z5GX1jljoA2IHrC/PL+jf4rPUpZ1WsaoCUC4Js8BUu2u0wbVQb7dZhPRc2biC7SvzKU/kl5rr1wFwJDR3ADhWwEl3fcTrOfZP8BQEmSot/VgEivP/HgFrGCNffmK+xrspl1qAiCiIN4peSbKY4zeTHECkKw8P0b7QfMm4kORV/2lNSLpSMHNR71youJHEPviWLL2o4NHZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtKwNOr9MbJUREJVch2yjLtjCzXfacn0Srv2WxN/lBY=;
 b=V0AT0xiBAKigM4oMUDyCoE1GpzuGeCSlUAzUpN/uEVApKKHzb29SO2MBQfqXTG0j1uGrmnSozT6yzlqvAGy4SUkweuT4BMriF3qa8z5pj0P1ihDPiKFc+HlcKXRLJfmH+KSyesql/2NjGpkoVJAhjO4az/d+5eu3aj4GmK4C74F5TIuNKpqwjAhPyTZWlcDIpVnkFRl76eX0bhbZfJ6g8mbuBwAGxhCHIJlLLRV9n27H3YxZGt471bx4PBKAO2yYmKS3/KsMYDVj9AeYX6v7SSYvi+B82+vP4nURCGDYKI/Ds0mH2AG5PKR4q8KtNRPGE6FWiqph16eLQSVl9i0eHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtKwNOr9MbJUREJVch2yjLtjCzXfacn0Srv2WxN/lBY=;
 b=apVm4PCXQUXZGwKOV/SylFAbOL2K1poXd0RHVxnK3DSLaO7Jycxi4F0l/brxVqhBiD+Wk2A8MJP+DvtVx3qHpB5Qa+iaPuecTtTe4/+1XshV1YfPG7w3J+kO1oBwYWHLr7nwKp4paeDGjEUqAerv/mJvLbq2CNCNkvOc7UM+03A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 10:56:30 +0000
Received: from PAXPR04MB8703.eurprd04.prod.outlook.com
 ([fe80::19a6:6003:3641:13b2]) by PAXPR04MB8703.eurprd04.prod.outlook.com
 ([fe80::19a6:6003:3641:13b2%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 10:56:30 +0000
Message-ID: <f8646acc-51e2-0461-cc1f-f341b84c9cff@oss.nxp.com>
Date:   Tue, 3 Jan 2023 11:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: drivers/media/platform/nxp/dw100/dw100.c:1574 dw100_probe() warn:
 missing unwind goto?
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
References: <202301031138.wkCMwZin-lkp@intel.com>
From:   "Xavier Roumegue (OSS)" <xavier.roumegue@oss.nxp.com>
In-Reply-To: <202301031138.wkCMwZin-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::33) To PAXPR04MB8703.eurprd04.prod.outlook.com
 (2603:10a6:102:21e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8703:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9e8960-6d73-4e4a-ed48-08daed792ada
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNvDGdh36BGSKQ2jJRAwA2r2UR2UUrW4eRVoI++fkGfUBvQufWlJaBQ3alZDtKqVxytsZTYJqVJ7YlBDskSvpU9SCaYMym0p06O9Oxldp7R2hgMA+82V+imBBbdphuXp7EBv7KBEx7e4rM+h/9Aaofh+8ZErAo34PMe0Awxgv4/JaLhw0GC3QjZ3hg0NtFI7O48TpOzVqMLTkFy2s7zoh0++K/ecxxq/xjLS9FO4IXWl7N5AiV6FEAxI7A2u09M5yVP9DPD2z28wLaQnSIqYbJ61aEJyAx6mJhWitTg+ubORCcTon3EN9utb08v5yaREOaguiQO5e1ULXeJiD63qldDWii9puPlgjAkGihvmke0M6LNldwrO0PHiUKcpDMlifM3Ml06xBl+ccb/VDKfze3lXoupatv5GH+aE6NM+Q+lsSEcg87cvGB7xkBEH4vY4pT7FbympvSwDpLZPIiRH0TtiqR4Gcbu2IGfBjiFrthOrSUeSPEfPlVy128aKzJ9Jj3yK2fbGKeofVfO3ulwrkaCoVa/hlL+CGAK9ZVSJzoAUFep7htpwEmElm29v+CErnyTbt3AK74Sp610x+HqQzNwJ1uABwjLCs9l3yqLUgyCle3zZT83Fg2cFoQZF6JdDucmEfzqQ9Ie/w2kRJuw8fQgeaAFoVxK/TwgGsz8NzleuvMub7huN4YSRWhz/bYfY9ElrfV7lF5m7x6oP8ypKsVIe8hA30doL4NdBz+ytOwG68TKa1pAXjg478XFzNqd0cOQDr4PsEsipVFeiGM7Cte4Q9qLevO4mHw07xvsKvFTKnpTE5jzBlEpLdC9DOHSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8703.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(83380400001)(6512007)(26005)(53546011)(6666004)(6506007)(31696002)(86362001)(38350700002)(38100700002)(2616005)(186003)(478600001)(41300700001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(966005)(6486002)(52116002)(66556008)(31686004)(66946007)(66476007)(54906003)(316002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdvMnV5b0lNTlIwdVRUbk5ta3dDbHBqUlRmc3FZUTEvTUFDZFREK3FUeHUz?=
 =?utf-8?B?dmJxVVlIRHVvQ0FIZi9tOHFSYW11YmJ0bnVzcjZ1aXZFWXVzUHNNelVlNjhv?=
 =?utf-8?B?RHVYYlkzWTRkM2FLcXBZYjNreTQrZGl6a1pMVmhZanhtSnZHQWpFMmhkWlhE?=
 =?utf-8?B?cDBsa3Z5Nm5PZVdSTG9jbjEwZHpJNWl2WmZaL1RmaWZ4VXk4TTBaZEF3QnlH?=
 =?utf-8?B?czRBVUF2bGNxaDgxS0F1TldoTXpjZW9VS3FOWWRJSlQzbTVrZVpLakc5N0Vr?=
 =?utf-8?B?Y2haL3BBdHpmWWNpU215b3hOYjQrNnRvYlEzRXBEa1dCazdPK1NyY21rZFlz?=
 =?utf-8?B?cWVJUEhmS21hUTBpTnNEaEMyQUVIN2dZOEZHMFFSdmpVYmZkSXNhYnYzQWF5?=
 =?utf-8?B?OGxGNUNld3B1QnUvalk5VW41bE1WSUo4OVJGYitpeE51bFhSU0tVcWRqeERt?=
 =?utf-8?B?d2J1SFdTSEhmSnJUbWVhZUFMNWZEYWZpZFNWeDdiZWlXQzZMWXpBQVR4dWMw?=
 =?utf-8?B?ZWtoOXhjYVRHbFV2cGN1S3duYkx4WjNoL0xXMjEyTXh0OXJNRllJVHhPMmZC?=
 =?utf-8?B?YzhCZFE4VlNaR1pkTjk1amhReHA5OThkR1g3T3JSRUk4SEZZSlE0dmRERE5y?=
 =?utf-8?B?cHFxWkk3dFJPbW5WY0NiQ1Ywa0g0NE5VeVAxZEVrRVJDQk5IMXhnMU9HMjBn?=
 =?utf-8?B?NWIyT0tKelltWUZQaFR3OHNEbmlWU3VmWHFEelRaVzNiaFZnZ2hjRnZKVzJq?=
 =?utf-8?B?TGZ5ZmpTQnFlaURXbk9DNndoWDlwb2oxU1pHZFBZKzdtaHFpRjBGMzdyN2hW?=
 =?utf-8?B?VDYzTTZsRk9pbncrWHQvek11TW43b2Uxd0tiRHZqUkwxMTNPNSs4Ym10U3VM?=
 =?utf-8?B?TzA4RTJVanorNUVhV2E1VHRWQkZiVzNnWGFzcit4YnppejBtbGtIWmE0S2Va?=
 =?utf-8?B?aDZKV3J5ek1yS0hZc0hOcE8yTi9HajhuUlc0Zy9Da3JQT3htdXRxTjhMelFu?=
 =?utf-8?B?amRBaklrZ3ZZK0l4Q0JpR3VHdi9nMEZWLzR2bGc4N21qK0dwRkliVmdyNDBE?=
 =?utf-8?B?Q1c2VnNaTkgxbjZKNDNDaXhXUFYxdjliVHBjV0FDRUdsV0hCTEpMYnpwaG85?=
 =?utf-8?B?bGZhM1FxTW1sbk5xN2pSTDdEUENSSkJyMEs1dFkrNjRidElrWlZNaXlOU3ZE?=
 =?utf-8?B?QWtRUEtDeGs2T1VwTmEwcVpCVDU4RGV3ZXFXZUF5ZEU0RXhPZGZ5b1dhelhv?=
 =?utf-8?B?NCtjRmNTZTA5dERxQUdndjBrZEVMQVFXYlpVaVhLTlVjVmU4TFpjYTN2UHho?=
 =?utf-8?B?enhXY3VCVEo3bDNaV3hzUk5Dd1p0YnFzQlNUeEdvVjBla0paVzdxYlRIb0F3?=
 =?utf-8?B?aWpwTFkyUlRCQnJIbUlSR0phSVg1bi9PS0N3NFp3QXVkZTVCTFMxNWVuRER1?=
 =?utf-8?B?V0xoaW1HY0RPYlF3dTRkcU1TNVpmVmY1c2o1M0NHTU15UlRNalNKaExzNWlB?=
 =?utf-8?B?OHpqWGZxZW1QQjRDSHhkUThTa3N4NmlNR3lpY0ErZ2c1bjZKZCt6VTFBZFc4?=
 =?utf-8?B?RnZDSEhsYlFGWkdCWXM0SVFHTlptNUF6allGWTBCZGx1QkxmbDVYOXh1ZThR?=
 =?utf-8?B?bnZpS1ZJc0F1dGszM29mUnI1TWx0dVlXWUtvQzErL0FTUjc4Z0VNOVJPTzVH?=
 =?utf-8?B?Nnp0Q05xaEVIeVVWSDBYT3Q3QXozMituWkJFSVh2UnYvVXVZWEt0SHoxSENC?=
 =?utf-8?B?WjlEYnFXa0UzdTZHaWZnNTRENG1FOCs5VjNmYWlKWC9iK0ViVHN2aUx6UStK?=
 =?utf-8?B?azdsWUYrd0xKNGc1c3BQY3lkMXlUaVZINDl2MmNQOWRzbXl6eFY5aUFldWhG?=
 =?utf-8?B?dVZ1enhvdnNPL2NZQXpvV2tDTTNUQlQyR3BXb1d4ZFJDTDRLKzVKdjd2Vlc3?=
 =?utf-8?B?UW1mZWFGZTVFTzJrM2Y4elVPWkxhb1NaampmcURxNC9XUG0rMUdhTDlpVWpU?=
 =?utf-8?B?bnlxd3FjS3VCRWpuYm5YMU43N2g1cWd2cVYrcGV4VTBKUUJQSTVuU2pYL1ky?=
 =?utf-8?B?R1J3UmVhSldUalZDTHVzV0l5N05HUzA0UU5GTldXcHNQZ0FnWWxMREVnNXk2?=
 =?utf-8?B?NkFOSDNPYm9FcXlKbmVxZ3hWckRPNFNzYlhDcW9meTJQcnFYZU4zNE9malY4?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9e8960-6d73-4e4a-ed48-08daed792ada
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8703.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 10:56:30.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUUWmY/vaL1ttpcDbZ2YzQoCCKd6Clz0jW7ScgMUjFIO+lzW9F3zGFEUH/2nEXK9IxFUortN1TvKIaas1k7vNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 1/3/23 09:13, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   69b41ac87e4a664de78a395ff97166f0b2943210
> commit: cb6d000fcaa6e2ee0e01937364c686690329bf5e media: dw100: Add i.MX8MP dw100 dewarper driver
> config: ia64-randconfig-m041-20230101
> compiler: ia64-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> drivers/media/platform/nxp/dw100/dw100.c:1574 dw100_probe() warn: missing unwind goto?
> 
> vim +1574 drivers/media/platform/nxp/dw100/dw100.c
> 
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1531  static int dw100_probe(struct platform_device *pdev)
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1532  {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1533  	struct dw100_device *dw_dev;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1534  	struct video_device *vfd;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1535  	struct resource *res;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1536  	int ret, irq;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1537
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1538  	dw_dev = devm_kzalloc(&pdev->dev, sizeof(*dw_dev), GFP_KERNEL);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1539  	if (!dw_dev)
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1540  		return -ENOMEM;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1541  	dw_dev->pdev = pdev;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1542
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1543  	ret = devm_clk_bulk_get_all(&pdev->dev, &dw_dev->clks);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1544  	if (ret < 0) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1545  		dev_err(&pdev->dev, "Unable to get clocks: %d\n", ret);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1546  		return ret;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1547  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1548  	dw_dev->num_clks = ret;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1549
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1550  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1551  	dw_dev->mmio = devm_ioremap_resource(&pdev->dev, res);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1552  	if (IS_ERR(dw_dev->mmio))
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1553  		return PTR_ERR(dw_dev->mmio);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1554
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1555  	irq = platform_get_irq(pdev, 0);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1556  	if (irq < 0)
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1557  		return irq;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1558
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1559  	platform_set_drvdata(pdev, dw_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1560
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1561  	pm_runtime_enable(&pdev->dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1562  	ret = pm_runtime_resume_and_get(&pdev->dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1563  	if (ret < 0) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1564  		dev_err(&pdev->dev, "Unable to resume the device: %d\n", ret);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1565  		goto err_pm;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1566  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1567
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1568  	pm_runtime_put_sync(&pdev->dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1569
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1570  	ret = devm_request_irq(&pdev->dev, irq, dw100_irq_handler, IRQF_ONESHOT,
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1571  			       dev_name(&pdev->dev), dw_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1572  	if (ret < 0) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1573  		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30 @1574  		return ret;
> 
> goto err_pm;
Indeed, this goto is missing. Thanks.
Regards,
  Xavier
> 
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1575  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1576
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1577  	ret = v4l2_device_register(&pdev->dev, &dw_dev->v4l2_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1578  	if (ret)
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1579  		goto err_pm;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1580
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1581  	vfd = dw100_init_video_device(dw_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1582
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1583  	dw_dev->m2m_dev = v4l2_m2m_init(&dw100_m2m_ops);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1584  	if (IS_ERR(dw_dev->m2m_dev)) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1585  		dev_err(&pdev->dev, "Failed to init mem2mem device\n");
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1586  		ret = PTR_ERR(dw_dev->m2m_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1587  		goto err_v4l2;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1588  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1589
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1590  	dw_dev->mdev.dev = &pdev->dev;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1591  	strscpy(dw_dev->mdev.model, "dw100", sizeof(dw_dev->mdev.model));
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1592  	media_device_init(&dw_dev->mdev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1593  	dw_dev->v4l2_dev.mdev = &dw_dev->mdev;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1594
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1595  	ret = video_register_device(vfd, VFL_TYPE_VIDEO, -1);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1596  	if (ret) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1597  		dev_err(&pdev->dev, "Failed to register video device\n");
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1598  		goto err_m2m;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1599  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1600
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1601  	ret = v4l2_m2m_register_media_controller(dw_dev->m2m_dev, vfd,
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1602  						 MEDIA_ENT_F_PROC_VIDEO_SCALER);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1603  	if (ret) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1604  		dev_err(&pdev->dev, "Failed to init mem2mem media controller\n");
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1605  		goto error_v4l2;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1606  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1607
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1608  	ret = media_device_register(&dw_dev->mdev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1609  	if (ret) {
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1610  		dev_err(&pdev->dev, "Failed to register mem2mem media device\n");
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1611  		goto error_m2m_mc;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1612  	}
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1613
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1614  	dw100_debugfs_init(dw_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1615
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1616  	dev_info(&pdev->dev,
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1617  		 "dw100 v4l2 m2m registered as /dev/video%u\n", vfd->num);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1618
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1619  	return 0;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1620
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1621  error_m2m_mc:
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1622  	v4l2_m2m_unregister_media_controller(dw_dev->m2m_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1623  error_v4l2:
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1624  	video_unregister_device(vfd);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1625  err_m2m:
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1626  	v4l2_m2m_release(dw_dev->m2m_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1627  err_v4l2:
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1628  	v4l2_device_unregister(&dw_dev->v4l2_dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1629  err_pm:
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1630  	pm_runtime_disable(&pdev->dev);
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1631
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1632  	return ret;
> cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1633  }
> 
