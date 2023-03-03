Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7F6A8EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCCB3T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 20:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCCB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:29:17 -0500
X-Greylist: delayed 3126 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 17:29:15 PST
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1114.securemx.jp [210.130.202.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE6231EA;
        Thu,  2 Mar 2023 17:29:14 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 3230Kiqh019185; Fri, 3 Mar 2023 09:20:44 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 3230KBlJ029304; Fri, 3 Mar 2023 09:20:11 +0900
X-Iguazu-Qid: 2wHHJG9eLncihoAxmA
X-Iguazu-QSIG: v=2; s=0; t=1677802810; q=2wHHJG9eLncihoAxmA; m=BEpf67Ihb7DzDSDIeUuHP0iW79t6aOu4bw6Lb3O8lIs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 3230K7tV007601
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 3 Mar 2023 09:20:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfA6zLeTqK+ljMrDWgHMyO7icRyXLSsivb8UiMyvk8Bw2bPaxUhV0ES2r/t16QwEN7rJobmkNz3OfF1sprHWVeIiway/tMU0qz+QQMsMsl6ZXBgBHHUZTjBDl9RIXriqBWlhTe2/2xaodlsswvpmLE4/fIIGKJH0tib0qQ2lt3Y3G4BuhUIcQIbkhBpd+UCOlKNnml7wpS0ck1JHGzIAAaCUTNrEVfZnb3dBQXz7ChGOOmSbIRLMyht67WnXRvbrrOJwc+v6jqlGMzc9uytdvZ9dB+vhLeReA6izOPfma0FHZtF5zi3E3oeTqET5G8Xd4Gu7wMfQN3v/pzcVTMMGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XYaXZUjFffZbHTmILx+1P6hno8dAJCX2PBbuWGvfv4=;
 b=Jm23GSl4xgc2Y+2uAP4MXcQU7oYk2q5ziIJW3m7eHP+dt0nYxahWK4ZdF0Ki3R+D9d+crAo2J3JmF4MTISS2syrhCmkFvMg/dOICM5n5z+dXm5IWSBfepl/pYzircTrpujSzk0aC5lisOR3S6RyU30lOzHxAxquwKC8gm/hKKU6Lw5+KHmZrf2qlVlwRwnt1Duvt8jV0DcwKlebPyXs/t6vZGOOaO2oCjw3peb3Pazic225xFKylDDUvFBtn1l2YlazAPDoukEWt5mYSbdabfmk2q1KSa1ntJjphUbnG4DSTUxzpsRS21u8sWZgeGPuiQBQJSCuaBcdQk8LgQkiZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-amarula@amarulasolutions.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
Subject: RE: [RESEND PATCH] clk: visconti: remove unused
 visconti_pll_provider::regmap
Thread-Topic: [RESEND PATCH] clk: visconti: remove unused
 visconti_pll_provider::regmap
Thread-Index: AQHZTUixo+SUP4a0uEq1jFf2Xt5+y67oMKmQ
Date:   Fri, 3 Mar 2023 00:20:04 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420F7F55C341DEC3E9E9CEF92B39@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230302205028.2539197-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20230302205028.2539197-1-dario.binacchi@amarulasolutions.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11030:EE_
x-ms-office365-filtering-correlation-id: 575148df-837a-4c04-f24c-08db1b7d09b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdcdBMYgHzxj4wK3TiQVNVOv5Uf8vr+enDe7dfguatEd+JiQhbyAKOrgm7UwiOy18RkR3bBaUxY93m7B5YOzvQFhQDzLprRqNoFpHpXFRtgPKUaWhR9KkGgLUU1VrmsRjw46KWomcUz3ORS7AS1w6CgQabzeQfEJnc1VM1osVIgRMu2KPgxjWbwwoiuOZ0QpGwzdtCbR60rnnvsAPmeKo1iL21dnr7uf0Smid8eJjFCTsQNuk+9bSLonKiBWq3ePYsWlatFp+VZdUdWZjBksyuWvTYmwX5n7L0mx4dwK9+m12smdgP9TTMYFg7uUe8NM1T5bQ8UggxjvP3uTMw+k6ONdij89JWgSv3kuFD51W16YjpQGvUSX7nZvszL55FO6MJ7m4D3T95g9iU+3qM6KAFQJ43gWIg5ZNgLhwOhK9ABqCtSh0P7Z+yzlmJkScGRy1CnZAteV0gEmXLFjBfVFrr/3+9fuQd69WH16y7BdCpTt2X9naMMgJpb3P4DQ3RTDhgUPV5vpnpPqz4DZFfqldOS8/vHYeF65+k1ktsqNS138vbEdVac74iZnJGV0mfh6T6BcXcr8Ymf7mFO5yJ5ZM18NRMp5QkrztSiDIXin0GcFjCAzuCcsJ4UqPWwhI43Cr/X1q7hvvDJkc9hPlS3ydVTDszyJWSpHcT3RNlQCW23EC2u0Yjc0i0q1+6Js2hRw4xUtejMAyq+ic2z7FUP++g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(41300700001)(8936002)(52536014)(4326008)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(38100700002)(2906002)(55016003)(122000001)(33656002)(86362001)(38070700005)(5660300002)(7696005)(26005)(71200400001)(9686003)(186003)(6506007)(55236004)(53546011)(478600001)(110136005)(83380400001)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N2xQS2czUVVRbW80OFg4Sk9id0NGL0ZqMUxkMnNEbmZ0eCtqM0pYR3dQ?=
 =?iso-2022-jp?B?bTkwUm5uT3YwZ0pEUUt5bm9MVldiZmN4NzNOeXVxZzREcFRvVmR2MWZw?=
 =?iso-2022-jp?B?Uk5sbWIrT0JMWVZQcCttY2k2OGk4Z1IvbWhuWUl0TjV6RUU2QkZLZEFj?=
 =?iso-2022-jp?B?b2lBbk8ralJhazZGWU5RN2xqZk1ueUplQ1dCcXFiMVhtb3J2OXBnTWU0?=
 =?iso-2022-jp?B?czQwbE1CMTQyc09FeStWQkxJUkxBU2lrNWZnd0pJeUxMSjMzaDZjWjBG?=
 =?iso-2022-jp?B?QkFCK2ZsZEQ4WVRQM0dybEFHQTRnL3hCUWdNOE5TSkRkdGZMUUhxZjkz?=
 =?iso-2022-jp?B?VVl1N3l2TXc2WG9nUXk5K3pzQXFhOEVEczNhby9oVno1cFh2TmQ1eERV?=
 =?iso-2022-jp?B?cUl2RG5IQzNQTTNOTGxJZGF0UGtEdCtyc0hOSk05SGp6MlZRMzJVYWJI?=
 =?iso-2022-jp?B?dkwwRS9WZkpLYXpwellDS1NONlhBOHkvamRRQjFxOGl1Mm1nUkhYU3Zi?=
 =?iso-2022-jp?B?U0JIUVFwbEloanRFUTdNejRWSFlIaGZGYnkrdHJDdFY2QzVkREJ2Q1h6?=
 =?iso-2022-jp?B?VkNmZEUyRmhVeGZpQ3kyY0tvVUZGSDBaTk5lMVk4bmc1YnE3ZlFXMVBR?=
 =?iso-2022-jp?B?aG9PSWdBR2lQUXgxdHZibGhJWndYZm9hZ01JYWFXeEhqVklNZUlXajZP?=
 =?iso-2022-jp?B?NmdGa1MyUVphMjJxMk8yNWV1dkxtaHZqQ0VuSnJyQWI1dzRUcWlrTkVR?=
 =?iso-2022-jp?B?TlFBWk0vVVFOZkViNSsvYmRqZm1MMENzZTVOSWJNYjV4d0s1bk90cSsx?=
 =?iso-2022-jp?B?WGFDSXNNZzByei9janVtR29uZ0I3b1lZUlNyYnptVDUzMjJiVTdIcHc1?=
 =?iso-2022-jp?B?Nld3M29wY05sZ1BlQy9wNExvRGdhRlZTNDNNR1pheldCV1pTOWhPZzVp?=
 =?iso-2022-jp?B?SFBqekpiMWltOVg0dHNncVh6UTBpODBTWmcwdlFuSWZPOWdDNi8vcWZT?=
 =?iso-2022-jp?B?c3pWOE9IMHkzeTUvSndRdGxGUCtSbWhYNDZ1SDNUZG1xUlRsVW1Jb25o?=
 =?iso-2022-jp?B?aE1VcUMzRjRseGFpM2p6SmdTVURwcEZneElvRzVvNWI5WG5qQUZSMWlY?=
 =?iso-2022-jp?B?VGYrVzhoVFl5QjFodzcwSkViaFVwT3NPSVdrODJjSnFQZ2N6cUpGeVh2?=
 =?iso-2022-jp?B?TzdFemdHT29IcUZLUzY5Tm11VHYxYVdBUW92L3FRQVBnT3o1UEx0QW5R?=
 =?iso-2022-jp?B?Nm91WHhLMk9BUDJleGpYZjBMdE9nVmd5Qjh6cTllTmFYcmNxMjJBeG43?=
 =?iso-2022-jp?B?M1ppeS9pUWJ3d09TRm5RQ3hteVZTam1GRnZmd3pVNSs2M21kZWljK3gz?=
 =?iso-2022-jp?B?djlIUzVLTzUxNUd4dTk3VGc2UjNRc3Q3VUlYMkpHcWNTMWdEUzdHQlMv?=
 =?iso-2022-jp?B?K2Y1S1pRbDdwd09nM0NCY3lpNS8yTG5NM1JGRmNEYnYxVS84eDhRVGJM?=
 =?iso-2022-jp?B?U1gxajQ1T0tCd3NmZmwvcDZ6cGN5TnhEcUVXai9JOXg3ZlVYdkZvVDk0?=
 =?iso-2022-jp?B?b0hDRWdnWklMR0szUG11VG40Nk5aeGRBWGRKdGkyMFRzUzFXMTJVRVpG?=
 =?iso-2022-jp?B?SndUb2ZXTjlNblVTeE5acFJnK2FHNXdlYUF1eEFjY3MwUkE1dTlqREY3?=
 =?iso-2022-jp?B?ZkNoTzJPK1ZiLy94VFRxTWpVUDNsSTdaMk9HV0lIYzJHOUc5UGg0NndW?=
 =?iso-2022-jp?B?QUkrRXdwNkQ4MlUzeDRnbDFTNURMZXRUUlBtZjI1Um82bStkZGM2VUYx?=
 =?iso-2022-jp?B?a3c5cE1LZng1N1M1RmFmOG1BSUE1aytMWFhWSXFVbWh1b1UvYlZ0cDJY?=
 =?iso-2022-jp?B?WDZ0SHpkZlhsdnhvTjJYdHlVSVpyOVNGeDhySGVENUw2WXhRZ2JBVld1?=
 =?iso-2022-jp?B?MGUyTXM0cnNDcUY3ZTU3MFVPMkV0WFlSeXEzUU9sdjBPSnFXY0NYWXRU?=
 =?iso-2022-jp?B?NjZFeW1USlBndExKcnFteDJSbGxUaWRycHV4QnRtd2VSd2YzbmwvdkZU?=
 =?iso-2022-jp?B?ZCtjY1R3WGgwL3hpOWdIUGNJUUE4NmQvK1o5OG95amNGRnNGYTVOamUx?=
 =?iso-2022-jp?B?MUJaS09JME1NRTRvaVFoQzRvb1JYQUJoSE9DbjgrY2pHTGcydm1oVWNj?=
 =?iso-2022-jp?B?WmhJUzlHc0JOdEM5V1UyYjVrelRoenVybTdXTzdYTGtHRTFBUHF0QXlZ?=
 =?iso-2022-jp?B?eDNSWDRNM0pKekJMSm96L2J5UzdRb1dMeG9tZGxxc3NBMDBnbXo1Smt6?=
 =?iso-2022-jp?B?RDdUdVE3Nnp0V2liWnB2Y0E0Zjg0WWZXd2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575148df-837a-4c04-f24c-08db1b7d09b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 00:20:05.0197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1etybGI+WblGIA1v+bItWDYHt7xcTNcKTWGWK9Q7ZWT8zmoty0llk+yUuizzTP3flcLmvAAo6F+geAzW/jGfPs/s9oE8Uowrkj2bP9SDnNWaYp0YGTe4wW6qXi5Njhds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11030
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> -----Original Message-----
> From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Sent: Friday, March 3, 2023 5:50 AM
> To: linux-kernel@vger.kernel.org
> Cc: linux-amarula@amarulasolutions.com; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Michael Turquette
> <mturquette@baylibre.com>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣ
> Ｔ) <nobuhiro1.iwamatsu@toshiba.co.jp>; Stephen Boyd
> <sboyd@kernel.org>; linux-arm-kernel@lists.infradead.org;
> linux-clk@vger.kernel.org
> Subject: [RESEND PATCH] clk: visconti: remove unused
> visconti_pll_provider::regmap
> 
> Field regmap of struct visconti_pll_provider is never used. Remove it.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

> ---
> 
>  drivers/clk/visconti/pll.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h index
> 16dae35ab370..01d07f1bf01b 100644
> --- a/drivers/clk/visconti/pll.h
> +++ b/drivers/clk/visconti/pll.h
> @@ -15,7 +15,6 @@
> 
>  struct visconti_pll_provider {
>  	void __iomem *reg_base;
> -	struct regmap *regmap;
>  	struct clk_hw_onecell_data clk_data;
>  	struct device_node *node;
>  };
> --
> 2.32.0

