Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2375FAB81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJKEAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKEAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:00:11 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6913D13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1665460804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z6r+HKy9T1WeO6PF4/wIRAjD7AgVHkIIxtjlPYcjZ5k=;
        b=MouvlVZGb3cnHLG2ssdb25T4E9ZLG3GpGm6qDUVAVgJcrzn4FPvdfX17n/i96Hw3dn3E+o
        CtJyauJl8/OXgZwAIr7VCIC2/HCakSKjn4odE/gihv42DyMNc3OVd2+xLu7nvtFrgo4D4g
        1mWeEAX6XDzsJe1k2x5tqXbz4bfk76TXMhzvPoRssaWTGYh2b8CI+GiX77wltkKPXNw3La
        +n+Tb/QqamkycwWiLrlY9azlTbNHXcnNXIRyDnDF7U1npnwKVa97HQsjGZYvVwSfXjd1iN
        Oe+VfD7kifYiZG/z4CYLpJsjbJkcpiPNA0eEtvacZVp0KnUOHPqB22HGYPkppw==
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-v4qeN03-N3SHWYl6kO5kPA-1; Tue, 11 Oct 2022 00:00:00 -0400
X-MC-Unique: v4qeN03-N3SHWYl6kO5kPA-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by PH7PR19MB6732.namprd19.prod.outlook.com (2603:10b6:510:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 03:59:56 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::4d61:1edd:74f5:342c%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 03:59:56 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH RESEND] x86/devicetree: Add support for boot time
 interrupt mode config
Thread-Topic: [PATCH RESEND] x86/devicetree: Add support for boot time
 interrupt mode config
Thread-Index: AQHY1wejNb5MBDY3IkOIWGU+3msB+A==
Date:   Tue, 11 Oct 2022 03:59:55 +0000
Message-ID: <MN2PR19MB36935B4E28DFC9664FE69AB3B1239@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <20221003090750.10348-1-rtanwar@maxlinear.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|PH7PR19MB6732:EE_
x-ms-office365-filtering-correlation-id: a03faaa0-ba20-480c-edd6-08daab3d0f00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: QeUsH3GK8dWtJeQofypXeOR503JHXhxjuXVGH41kAtnzBX9Td4DbR2twU7rbxAiwvKqaRQwyvGszSGfoANkC9Q5oOvRoOjzfZ3jNouzMsoRr0lsWfI7001kGmcu7tBGORjdH10mxDVqJ2SaLZs5jAsEwgRxt/kqFyVxSiu0TYbqPMkJdujKxB/Nw9pfw1fsIBrj5tU9QiUrMhq09GGkdzYP5M49CRi6uSITPDa5VpMu3LPWou4bjya9fYKDIjNGJgznrD0xVfBR+3C2nvPKiIOIJZ7kNN+dWnzYyfn5TldiZ6wlYx0XR98Yy9pqCRintuJOmC3qA/8NXV89ZhbVta+650JngL34lTD9BGwUsWP8QzAuqyAKgDbQJsl/BlqZQfcgEbK4qu1oqb7zc81jhvLlGg67Dqhi46tI7pAreO1muD0axjwWqJcOzXB56kP4G9Kh0W1lKCnbrHdR+d6EoyDYjcnAVGcNfvx8SKUTx/wrlE7NJ2WqiJbhWf4BEScbN82EykZo4VZcJQGs36nHAyFNt0ECleXipcIaSBYfj6A0MFdl6UU+Kps7QWx1r3j5nVYqvnx+cUytcvp4AiMSx4v8QZpN6Te7bo8UJ4KWPNcpIItHQsROdIz3rbRqBFge/L5iKe0ReJw4GwRkZ/dcVkEjx38CjdBi23yhkvpuxf7uXrAGJ9hwnk8+o9wuWbGE1qb4auWrr880XwdrLu7PdOczwMoADSyGJV4fclBBtzl4D7qSBasMT19lVKbfR9mt2rU/kWw15VRFKHti+vTvqVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(376002)(396003)(346002)(136003)(451199015)(55016003)(33656002)(478600001)(9686003)(7696005)(6506007)(64756008)(8676002)(38070700005)(110136005)(41300700001)(66946007)(71200400001)(66556008)(76116006)(4326008)(66476007)(91956017)(26005)(38100700002)(86362001)(83380400001)(66446008)(186003)(5660300002)(8936002)(52536014)(122000001)(53546011)(2906002)(54906003)(316002)(107886003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zzswLiaYoQ4jx8myFAFFYe1APOcp4mY8qlAiJF2qHGk3Ya6BrsT0pcLQkcJx?=
 =?us-ascii?Q?n+Lvh5K87K7UphW1cIf/UcPAQDXhJgwCZJt2FrJovSrOt3XyOZttBHL7CgMM?=
 =?us-ascii?Q?E1Vk7hEXLfKdzHm7HwhoM3DW1ANDp2k+ZGDi6ySqSBeMG43XA/6vJ/MqTWSj?=
 =?us-ascii?Q?EPWIZOjaLLfz07RolMPMoYqbec6isrMvFc7rM0HN4HRzx7b7xX0jm8o8uCNw?=
 =?us-ascii?Q?VxvBXuJDtd0QzXbF9uqkOPfZvUuHJH0tRLB4JtXfT23F2xXX+VeHzjbhyzde?=
 =?us-ascii?Q?qJeE6i34t2QdAdn6zBCdpDsw7oiglnFFFC0ulxuePAZtQ4/iEx8bBafAvs0b?=
 =?us-ascii?Q?ul0ktIBSmcv+XR3/FFOkSVUltC12qtIsZ2jmXcWcRsLyVolhhvOnMFnOe+rS?=
 =?us-ascii?Q?KNeEXCcJv4hpLJSdWHxvVVKYN/SiXUuR3n1gKsqDBBkChsV3TER+Kq/WfCJ0?=
 =?us-ascii?Q?1FrkdXiO3aVvHiudIzSrjGprCbLQsv1ww+E9rUqNNeVfSQwP1NCH1QEa2ghh?=
 =?us-ascii?Q?yMFwLIoFfbd03AlghlSnagcR/CmaEeDqTzSLot+C9dZbebR2vR1KAnk5Jo7E?=
 =?us-ascii?Q?9yDSyKfyR6UQ063VaxuVfh3W71SifrTMXFGyQFFTEVMBXwpB1T04WcJO3ZkF?=
 =?us-ascii?Q?Vgr0la0BXHAHKz6E1uoE/tjLhuoPnfC3+EdSDMW8cLgzWeMwQJB5yMx96bt3?=
 =?us-ascii?Q?Csnthe2CFhY2for1FSNkQMQoALGPv2xrQl7HNS5aN5cP93hG9IpCEF/1ISH8?=
 =?us-ascii?Q?xj8g5jMnYOOTmtps4wd0XUwGeJOlnMFOlBeUvgbF3reDkjBNyPgyyxLrZ7oh?=
 =?us-ascii?Q?6dzCKXiByXJqlaNyK2QsXpRGth20sUvzqvRz/tggqGMqD/cvSHM668Idsk7U?=
 =?us-ascii?Q?7mhnJsphqger8Ze3ExRyYGJFjKzbhHVS41sndZRXdBuowQRPZHAKYN00Mzyq?=
 =?us-ascii?Q?O1dNCBrK+gC4DU0p4P3nPpQYXg4iQxJ91m+afBX3TtYC1oA7KmJMNm6lQzvt?=
 =?us-ascii?Q?i11DspUARH5D6peNeXUI259HLaOZZThVUsni5/5f+dPpStx6MkjdMrAnp8UI?=
 =?us-ascii?Q?MSx36Pl4dT1qIs0Q5nETDVbjgkrECeaBBEa96ldsVMsEEcvQo6XrYh07i47m?=
 =?us-ascii?Q?D+GnRbld+K7UM7Lk432ehlKFXmZ9daxlmPle+iSVd1mxklAe7zEl5TLnH163?=
 =?us-ascii?Q?1VSzOetmR7G2P1ZA+r7/JZiIiy1zdUq1xHO52wdpcu/CavkZ6S/+o7NnmKcr?=
 =?us-ascii?Q?CnP1/Z2AzteGNQr+6xwJQezUSzFlpRFjxtdc8jx3FxDpducVYeCIPrpzGGYc?=
 =?us-ascii?Q?wRtp7smjHnGvTg5R56c8irnw0sfM6lSbIitCL/7mehkECBkf8bHqBCHRek8T?=
 =?us-ascii?Q?NuS/bhAv8euJmVwP0KwV52FqegRyEAP9RvVbus2ep456zbvAVmkWxpV+VrcH?=
 =?us-ascii?Q?RbAO5RGtJb/7IcYkVR5glKOQ9PpIHY8w/L5CPHU2vQcvV02o80x8v1BHgrMu?=
 =?us-ascii?Q?aNq38nw60peXXkfltMaX0OVb0JuBMbgg8JLKTm278AeqbO/l3WMz/btnj7bY?=
 =?us-ascii?Q?06M56D5Gmt7X/1/tuEvvdDFOLatW6ikFdLcFOR2YIBF+FAtQpsktKJ+ZBIm2?=
 =?us-ascii?Q?Rw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03faaa0-ba20-480c-edd6-08daab3d0f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 03:59:55.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxN+AhM8wmUvqCwSqdDOO04BRZFsksVQq34LRu8lZNcCRM/P3389cAkXVD/ybz2Z622lWW+9er6RNnQg2Ngttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6732
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 5:08 pm, Rahul Tanwar wrote:=0A> Presently, init/boot time int=
errupt delivery mode is enumerated only=0A> for ACPI enabled systems by par=
sing MADT table or for older systems=0A> by parsing MP table. But for OF ba=
sed x86 systems, it is assumed &=0A> fixed to legacy PIC mode.=0A>=20=0A> A=
dd support for configuration of init time interrupt delivery mode=0A> for x=
86 OF based systems by introducing a new boolean property=0A> 'intel,no-imc=
r' for interrupt-controller node of local APIC. This=0A> property emulates =
IMCRP Bit 7 of MP feature info byte 2 of MP=0A> floating pointer structure.=
=0A>=20=0A> Defaults to legacy PIC mode if absent. Configures it to virtual=
 wire=0A> compatibility mode if present.=0A>=20=0A=0A=0AAny comments or con=
cerns for this patch? IMHO, this configurability of=20=0Apic_mode was missi=
ng for OF systems & it should benefit other x86 based=20=0AOF platforms as =
well. Please let me know if i am missing anything about=20=0Ait or if you h=
ave other concerns.=0A=0AThanks,=0ARahul=0A=0A=0A> Signed-off-by: Rahul Tan=
war <rtanwar@maxlinear.com>=0A> ---=0A>   arch/x86/kernel/devicetree.c | 10=
 +++++++++-=0A>   1 file changed, 9 insertions(+), 1 deletion(-)=0A>=20=0A>=
 diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c=
=0A> index 5cd51f25f446..de14015317f8 100644=0A> --- a/arch/x86/kernel/devi=
cetree.c=0A> +++ b/arch/x86/kernel/devicetree.c=0A> @@ -167,7 +167,15 @@ st=
atic void __init dtb_lapic_setup(void)=0A>   =09=09=09return;=0A>   =09}=0A=
>   =09smp_found_config =3D 1;=0A> -=09pic_mode =3D 1;=0A> +=09if (of_prope=
rty_read_bool(dn, "intel,no-imcr")) {=0A> +=09=09pr_info("    Virtual Wire =
compatibility mode.\n");=0A> +=09=09pic_mode =3D 0;=0A> +=09}=0A> +=09else =
{=0A> +=09=09pr_info("    IMCR and PIC compatibility mode.\n");=0A> +=09=09=
pic_mode =3D 1;=0A> +=09}=0A> +=0A>   =09register_lapic_address(lapic_addr)=
;=0A>   }=0A>  =20=0A=0A

