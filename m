Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED32B6C7A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjCXIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCXInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:43:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6F265BD;
        Fri, 24 Mar 2023 01:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxo3CnIACqQdp89MNuup32bf6uIS8p0IUSNNf/qhYmtjhVhG2UZe5VY0OWImX+eqTrR5EAP5gp3ybvti7I9PilXsmZZzgHyBRJwqHt5A7T38GmUg8TTt5Ki0aba1uhQ6E+LREIEggm5E6Nm65udadhllUzQKhHmtgjes4/v9OWBp/84PuKjI+Dl3qglchoN1AWOpD3NQYwAiGC726v70+b6G8liBKv1utIvSd2cEjrdTNQJf9fnLpM8Xyv9HruvFFv7y6WbRAFQr6Ew0yAxIpFIotXiwurqkX1jokotiaZYTvFkOvPMr6tpFtA+gyHKx9jF8L5gZZPOEBo6Ex9s4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKCbCGbl01Z2r9Qop4IwwZ77LzaU21nr4g1PAesLR7U=;
 b=ocLZjKwtfObsqa4MwO1y/sjwR+3t5FXPK3Vz9hJY+CC8QgPCoWFfFNjVwbJ0x+F9w7utAc9YKWZsJd8YtB/nIUSoXpssVwndJLm8V2ApnOOWgZLSoIQbzzYXAkjag8MTtXadCL+egi24RcWT4V4lpQdUyitEiBzNIlzdelN3K7icRRWzUfF24eBpt4jipV3DUIBoTXAkZ/pjyeaLQvpgnyLJJVI3ErCpcwBwm0nv7Yz68pnY0Z97mSggqt9uf7D8IfJ2Fesu7yoykOu/lndiIN/2zlsxc0jogyeXjyxvDYTvhyejfpzWsdhMZwVlb5N3QXuAHzpx+4J8u8lTmhfb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKCbCGbl01Z2r9Qop4IwwZ77LzaU21nr4g1PAesLR7U=;
 b=iw1xHPAMIgYWdJNEiIG4gQ2VQ3BJjDBZbKD3LVUArsFjvePGveae3HS8DLrbtWGdMLxR6oiSnFQe/EJpeITX1w7rskfzl7unRD8yQWbRIitlzWLZuNSO0/U7LpU7sy3MZHfAoZW2NXu8zUb7gUJ/vCc5Tg5oC+u7bi2x6pClX8KxzXm6FtIKsZLpXYsSMRJjiruyA4YAxTHT6mESs+hMhi7q9+8wHWc48PVscx/5xhSUQ7oWLXDINf0UlXBUDit0ujN4vY5a1CGx5//qlBx/MlwNifdrofbsifhOvsmRy8RY1p8iw01n4DaNHApuV9DeIOIRXWm0DmabqfuPcFPkQA==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by DB9PR10MB5932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 08:43:38 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e%2]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 08:43:38 +0000
From:   "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Kiszka, Jan" <jan.kiszka@siemens.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Topic: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Index: AQHZXitnsElEVi8SeUyEotrWHWfO2g==
Date:   Fri, 24 Mar 2023 08:43:38 +0000
Message-ID: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-24T08:43:38.030Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|DB9PR10MB5932:EE_
x-ms-office365-filtering-correlation-id: 4c511cda-1599-4eee-c708-08db2c43dcda
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQkIz4a9XiWGX0JtzJfDYWD3MiAofMWV4jNSub2DStOJowQCy3G1BNDmYAzXXCU1OBs0+5C2JXSjQxVU9SwZWd+7xme0Q3chWZVAYqna6Dj0/PQPpbHBtLGLJDrdMUJBn3JctKooHB/95QI0bpQ/+pcc0kzeD7BGM0ZAVO8wz0QbmjxVIKCnKVUEnkydu2EgenmOqXZJDKOdyW4cghoPIsXtSa8Ya8QbjLjOhz38VKvtAdU1ccavryaUp5pGkZFPfZ4Fe0xU8Uw6s6mUPx2blq0Dw7Ywuxt2MXAULWQwbBHVYlkXurmw7PiyYCKdiux1IElTalPk1HGpexcyxnaCbLwC+T0qJf0Vw2SJDTx+2xlFjfM8NyiJNV8zBCwqBjHCs/ySdyW9WX4oSzlBoqad3+Ycit1Tmj9tn2711YwvRqBueX7Di+sEHZ3qJzq1HI2W5nIEHczJwMmGnQUB4iywPkJLMOeCSVvnEGkqBpeDpVEkTbbEGXM+YBY/y28mIuWU2K0jbaUdftP5bcYlZNh6JMiTZ4JC9xKFc5fBjVy/6lbZBOBKMw0lD+A8JjxIHtO+bLe+jjszkbhq09yBIgriv2tRE+RzsdWeJBNIfqrxv+qmyO0r2aRizNFxdELk+V4mJS8sn78xbHwyZzuoaPl8SXSxu4KNPmn3qm2YdEwuFOA+jRUb+FkHqSXdqD/00lJ3S3Nr51zlnl7WQ0pZ+X8KOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(33656002)(66476007)(64756008)(8676002)(4326008)(66556008)(66946007)(66446008)(52536014)(76116006)(91956017)(41300700001)(5660300002)(122000001)(110136005)(316002)(82960400001)(99936003)(8936002)(55236004)(26005)(6506007)(186003)(9686003)(478600001)(83380400001)(966005)(54906003)(7696005)(71200400001)(86362001)(38070700005)(55016003)(38100700002)(2906002)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?409JOlNLqcCA8Z4IF+jxFjkqMIbJqJ1nLFJD3OP8ktSO1OJbdVTkwkmJO7?=
 =?iso-8859-2?Q?BRwoWjpDsdS2U9tS9Z5HgoDprfWyIeA8on10kyDz+08RMchlTrkakeJaal?=
 =?iso-8859-2?Q?54LbrfuEv4e1KZdnx4zplppfqnhaZvowhrNamCcFcve8uOgP8Bp33FBokt?=
 =?iso-8859-2?Q?EucuRtbXsBNNKEzJihb2J3ZdPFiAwK94Yopu720Rd+yBUVRl36EWInPIy1?=
 =?iso-8859-2?Q?VkkPDmvY0+60D0uZsWtSUES/Iy/6CaYzkQpdevC3aNlFQR96tG/zWB6zsJ?=
 =?iso-8859-2?Q?/c38ytpkz3gXa21nbTjVBREC/2dUYO2EmG+CvDasDRPmUGrYbXet8Q2sY3?=
 =?iso-8859-2?Q?/OZ9W+utZGhaf/2Fdjt21Dx6FkP6or8F8tuk8XaKeLNuYzAU8sA3XF9ltM?=
 =?iso-8859-2?Q?MTQCUcdZRRqXD4IeoKLd2UgQIRevAB6jSGusPw9fvF9y1M7qHqGaI3aQpm?=
 =?iso-8859-2?Q?SL+c7MmmkfWhzMhJZpR5cVr6RVrGkzD1NUGWHrIG4mbimP4VGSN8J00k2/?=
 =?iso-8859-2?Q?Pt4GtmqxNDgf1R8raBV1uaBdMphicizN7k3HpW7oOqwTaVji7fpkqhsXOW?=
 =?iso-8859-2?Q?pax7QIh1rwzihbIuN6fqcpAx93cDQCiaGP9drMPSloaeyE7xjgLxyrab8t?=
 =?iso-8859-2?Q?K2jYKBm4iiTJrvRyrQeCn1xjRa3d8Zl/r16XATLTodjPgcIesgi0dAi41g?=
 =?iso-8859-2?Q?omSPrmy8tK6INOBDW0uFe3quHN/8eLDP2Xn8Kavd+3ydois06lgLdASa13?=
 =?iso-8859-2?Q?SYZiu+6CQ7pFJlFzeV2dcmS0R3ZpYScXuIcWJWBZsaoJYdBRYd/+roj1Je?=
 =?iso-8859-2?Q?CrOWhEQGepUeS7QJ05qYX/BPt3yFfSmvCNGtPAfVS02xWWrXw/BUFUiyuV?=
 =?iso-8859-2?Q?MELMqdSaNp9G5dgWFDuJf21y9qtmE9XuJuS0TxpC2BkhHmiYv+bahFM1xf?=
 =?iso-8859-2?Q?z2lUFUSjszmMrYyDr9MamekXNWXtegfFwyHpion0D4R6HCqe4hpgJl1Mgy?=
 =?iso-8859-2?Q?XUD2PDC9/wqYOTGbqf6BZRwMWh6a+HnZgy39wduFyP9JZp2UgWCijv9Pez?=
 =?iso-8859-2?Q?YlgNhfXYY539FKQ9rscQfS+Dr5UmqgUhikxmNP5aavk/eiQguzWsrPqb3Q?=
 =?iso-8859-2?Q?kIW0V8MOM/qpDOiixn6Mz3Y85+xVZOvRxfB12dGr1EqVGE99e7mkFNrdYD?=
 =?iso-8859-2?Q?NoPJXfT453pJ9qW8fwwV6foM0DiPfhHZlLeBPXI67pBvsoL+zTIPgakkUO?=
 =?iso-8859-2?Q?HxLNPs+ZKbP8DT28NpBMJ9uF0owEFJYofCo5lGXxzG5HIbEopq8cSaY5Em?=
 =?iso-8859-2?Q?rLRX8qmsKTpDxfMbe4MdLXneP/w/TfifFOrVpyqMi+Hhyjz20dTTPHbqC6?=
 =?iso-8859-2?Q?zJlcRkInC1DmcavwNdCDaKlYtes3bdSy609lZgpNM7//QxxiQysJwrFRJK?=
 =?iso-8859-2?Q?tp4S3hWq83sIlQWjaJYfbbo58rJr4f+bTA0GA70SsZlv4QacsBQocDsvXf?=
 =?iso-8859-2?Q?SSXDCvfMqQqsLytFHo5VPDbWHgDFUgI5j+JLsjaq+HCDCbxmZg61p51VLn?=
 =?iso-8859-2?Q?4hvwhxWFjeuqaT4Z+Hbxgb3XjHd2vGCgB8A/TX0q+NJwYFG5N746IOCb/J?=
 =?iso-8859-2?Q?aSA3kRi7gBrgnrdlmoTZysvWOHN3DPGxXSYIpqUy8BXMiq9zUmCJou6Q?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_003_AS1PR10MB56750EFD7BEA779D033A68CBEB849AS1PR10MB5675EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c511cda-1599-4eee-c708-08db2c43dcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 08:43:38.2344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jzy6Pt3XzNM93GHwPoCeadx3swZbYrINClcFiZ20KSGZpfFntJpH6Ry3YiyGpB/5paosV5wYWScdMqMZKTUbZwg+4UOKvwN33Y1OLyVNcDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5932
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_003_AS1PR10MB56750EFD7BEA779D033A68CBEB849AS1PR10MB5675EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello,=0A=
=0A=
I have seen ~3 ms delay in interrupt handling on ARM64.=0A=
=0A=
I have traced it down to raw_spin_lock() call in handle_irq_event() in=0A=
kernel/irq/handle.c:=0A=
=0A=
irqreturn_t handle_irq_event(struct irq_desc *desc)=0A=
{=0A=
    irqreturn_t ret;=0A=
=0A=
    desc->istate &=3D ~IRQS_PENDING;=0A=
    irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);=0A=
    raw_spin_unlock(&desc->lock);=0A=
=0A=
    ret =3D handle_irq_event_percpu(desc);=0A=
=0A=
--> raw_spin_lock(&desc->lock);=0A=
    irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);=0A=
    return ret;=0A=
}=0A=
=0A=
It took ~3 ms for this raw_spin_lock() to lock.=0A=
=0A=
During this time irq_finalize_oneshot() from kernel/irq/manage.c locks and=
=0A=
unlocks the same raw spin lock more than 1000 times:=0A=
=0A=
static void irq_finalize_oneshot(struct irq_desc *desc,=0A=
                 struct irqaction *action)=0A=
{=0A=
    if (!(desc->istate & IRQS_ONESHOT) ||=0A=
        action->handler =3D=3D irq_forced_secondary_handler)=0A=
        return;=0A=
again:=0A=
    chip_bus_lock(desc);=0A=
--> raw_spin_lock_irq(&desc->lock);=0A=
=0A=
    /*=0A=
     * Implausible though it may be we need to protect us against=0A=
     * the following scenario:=0A=
     *=0A=
     * The thread is faster done than the hard interrupt handler=0A=
     * on the other CPU. If we unmask the irq line then the=0A=
     * interrupt can come in again and masks the line, leaves due=0A=
     * to IRQS_INPROGRESS and the irq line is masked forever.=0A=
     *=0A=
     * This also serializes the state of shared oneshot handlers=0A=
     * versus "desc->threads_oneshot |=3D action->thread_mask;" in=0A=
     * irq_wake_thread(). See the comment there which explains the=0A=
     * serialization.=0A=
     */=0A=
    if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {=0A=
-->     raw_spin_unlock_irq(&desc->lock);=0A=
        chip_bus_sync_unlock(desc);=0A=
        cpu_relax();=0A=
        goto again;=0A=
    }=0A=
...=0A=
=0A=
I have created a workaround for this problem by calling cpu_relax() 50=0A=
times after 100 failed tries. See attached patch=0A=
3ms_tx_delay_workaround.patch.=0A=
=0A=
I have created custom kernel module with 2 threads, one similar to=0A=
irq_finalize_oneshot(), second similar to handle_irq_event(). I have used=
=0A=
latest Linux 6.3-rc3 with no added patches and I confirmed that even there=
=0A=
qspinlocks are not fair on my ARM64 board.=0A=
=0A=
I copied qspinlocks code to the module twice and I have put traces only to=
=0A=
one thread, the one which takes several ms to lock and is originally=0A=
called from handle_irq_event(). I have found out that the=0A=
queued_fetch_set_pending_acquire() takes those 3 ms to finish. On ARM64=0A=
queued_fetch_set_pending_acquire() is implemented as=0A=
atomic_fetch_or_acquire().=0A=
=0A=
I have found out that my CPU doesn't know LSE atomic instructions and it=0A=
looks like atomic operations could be quite slow there. Assembler code in=
=0A=
arch/arm64/include/asm/atomic_ll_sc.h has loop inside:=0A=
=0A=
#define ATOMIC_FETCH_OP(name, mb, acq, rel, cl, op, asm_op, constraint) \=
=0A=
static __always_inline int                      \=0A=
__ll_sc_atomic_fetch_##op##name(int i, atomic_t *v)         \=0A=
{                                   \=0A=
    unsigned long tmp;                      \=0A=
    int val, result;                        \=0A=
                                    \=0A=
    asm volatile("// atomic_fetch_" #op #name "\n"          \=0A=
    "   prfm    pstl1strm, %3\n"                \=0A=
    "1: ld" #acq "xr    %w0, %3\n"              \=0A=
    "   " #asm_op " %w1, %w0, %w4\n"            \=0A=
    "   st" #rel "xr    %w2, %w1, %3\n"             \=0A=
--> "   cbnz    %w2, 1b\n"                  \=0A=
    "   " #mb                           \=0A=
    : "=3D&r" (result), "=3D&r" (val), "=3D&r" (tmp), "+Q" (v->counter)   \=
=0A=
    : __stringify(constraint) "r" (i)               \=0A=
    : cl);                              \=0A=
                                    \=0A=
    return result;                          \=0A=
}=0A=
=0A=
Most importantly, these atomic operations seem to make one CPU dominate=0A=
the cache line so that the other is unable to take the lock. And that is=0A=
problematic in combination with the retry loop in irq_finalize_oneshot().=
=0A=
=0A=
To confirm it I have created small userspace program, which just calls=0A=
__ll_sc_atomic_fetch_or_acquire() from two threads. See attached=0A=
unfair_arm64_asm_atomic_ll_sc_demonstration.tar.gz. Bellow you can see=0A=
that it took 16 ms for one atomic operation.=0A=
=0A=
# ./contested=0A=
load thread started=0A=
evaluation thread started=0A=
new max duration: 6420 ns=0A=
new max duration: 9355 ns=0A=
new max duration: 22240 ns=0A=
new max duration: 23180 ns=0A=
new max duration: 70465 ns=0A=
new max duration: 77860 ns=0A=
new max duration: 83100 ns=0A=
new max duration: 105115 ns=0A=
new max duration: 127695 ns=0A=
new max duration: 128840 ns=0A=
new max duration: 1265595 ns=0A=
new max duration: 3713430 ns=0A=
new max duration: 3750810 ns=0A=
new max duration: 7996020 ns=0A=
new max duration: 7998890 ns=0A=
new max duration: 7999340 ns=0A=
new max duration: 7999490 ns=0A=
new max duration: 12000210 ns=0A=
new max duration: 15999700 ns=0A=
new max duration: 16000000 ns=0A=
new max duration: 16000030 ns=0A=
=0A=
So I confirmed that atomic operations from=0A=
arch/arm64/include/asm/atomic_ll_sc.h can be quite slow when they are=0A=
contested from second CPU.=0A=
=0A=
Do you think that it is possible to create fair qspinlock implementation=0A=
on top of atomic instructions supported by ARM64 version 8 (no LSE atomic=
=0A=
instructions) without compromising performance in the uncontested case?=0A=
For example ARM64 could have custom queued_fetch_set_pending_acquire=0A=
implementation same as x86 has in arch/x86/include/asm/qspinlock.h. Is the=
=0A=
retry loop in irq_finalize_oneshot() ok together with the current ARM64=0A=
cpu_relax() implementation for processor with no LSE atomic instructions?=
=0A=
=0A=
I reproduced the real life scenario of TX delay only in ICSSG network=0A=
driver (not yet merged to mainline) [1], it was with kernel 5.10 with=0A=
patches, CONFIG_PREEMPT_RT and custom ICSSG firmware on Texas Instruments=
=0A=
AM65x IDK [2] with ARM Cortex A53. This custom setup comes with high=0A=
interrupt load.=0A=
=0A=
[1] https://lore.kernel.org/all/20220406094358.7895-1-p-mohan@ti.com/=0A=
[2] https://www.ti.com/tool/TMDX654IDKEVM=0A=
=0A=
With best regards,=0A=
Zdenek Bouska=0A=
=0A=
--=0A=
Siemens, s.r.o=0A=
Siemens Advanta Development=

--_003_AS1PR10MB56750EFD7BEA779D033A68CBEB849AS1PR10MB5675EURP_
Content-Type: application/x-gzip;
	name="unfair_arm64_asm_atomic_ll_sc_demonstration.tar.gz"
Content-Description: unfair_arm64_asm_atomic_ll_sc_demonstration.tar.gz
Content-Disposition: attachment;
	filename="unfair_arm64_asm_atomic_ll_sc_demonstration.tar.gz"; size=3522;
	creation-date="Fri, 24 Mar 2023 08:34:29 GMT";
	modification-date="Fri, 24 Mar 2023 08:40:53 GMT"
Content-Transfer-Encoding: base64

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

--_003_AS1PR10MB56750EFD7BEA779D033A68CBEB849AS1PR10MB5675EURP_
Content-Type: application/octet-stream; name="3ms_tx_delay_workaround.patch"
Content-Description: 3ms_tx_delay_workaround.patch
Content-Disposition: attachment; filename="3ms_tx_delay_workaround.patch";
	size=1853; creation-date="Fri, 24 Mar 2023 08:34:29 GMT";
	modification-date="Fri, 24 Mar 2023 08:40:53 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9pcnEvbWFuYWdlLmMgYi9rZXJuZWwvaXJxL21hbmFnZS5jCmlu
ZGV4IDhjZTc1NDk1ZTA0Zi4uMWY5NzZmMzZjZDU2IDEwMDY0NAotLS0gYS9rZXJuZWwvaXJxL21h
bmFnZS5jCisrKyBiL2tlcm5lbC9pcnEvbWFuYWdlLmMKQEAgLTEwNjcsNTEgKzEwNjcsNTkgQEAg
c3RhdGljIGludCBpcnFfd2FpdF9mb3JfaW50ZXJydXB0KHN0cnVjdCBpcnFhY3Rpb24gKmFjdGlv
bikKIAkJfQogCQlzY2hlZHVsZSgpOwogCX0KIH0KIAogLyoKICAqIE9uZXNob3QgaW50ZXJydXB0
cyBrZWVwIHRoZSBpcnEgbGluZSBtYXNrZWQgdW50aWwgdGhlIHRocmVhZGVkCiAgKiBoYW5kbGVy
IGZpbmlzaGVkLiB1bm1hc2sgaWYgdGhlIGludGVycnVwdCBoYXMgbm90IGJlZW4gZGlzYWJsZWQg
YW5kCiAgKiBpcyBtYXJrZWQgTUFTS0VELgogICovCiBzdGF0aWMgdm9pZCBpcnFfZmluYWxpemVf
b25lc2hvdChzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MsCiAJCQkJIHN0cnVjdCBpcnFhY3Rpb24gKmFj
dGlvbikKIHsKKwlpbnQgaTsKKwlpbnQ2NF90IGFnYWluX2NvdW50ID0gMDsKIAlpZiAoIShkZXNj
LT5pc3RhdGUgJiBJUlFTX09ORVNIT1QpIHx8CiAJICAgIGFjdGlvbi0+aGFuZGxlciA9PSBpcnFf
Zm9yY2VkX3NlY29uZGFyeV9oYW5kbGVyKQogCQlyZXR1cm47CiBhZ2FpbjoKIAljaGlwX2J1c19s
b2NrKGRlc2MpOwogCXJhd19zcGluX2xvY2tfaXJxKCZkZXNjLT5sb2NrKTsKIAogCS8qCiAJICog
SW1wbGF1c2libGUgdGhvdWdoIGl0IG1heSBiZSB3ZSBuZWVkIHRvIHByb3RlY3QgdXMgYWdhaW5z
dAogCSAqIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86CiAJICoKIAkgKiBUaGUgdGhyZWFkIGlzIGZh
c3RlciBkb25lIHRoYW4gdGhlIGhhcmQgaW50ZXJydXB0IGhhbmRsZXIKIAkgKiBvbiB0aGUgb3Ro
ZXIgQ1BVLiBJZiB3ZSB1bm1hc2sgdGhlIGlycSBsaW5lIHRoZW4gdGhlCiAJICogaW50ZXJydXB0
IGNhbiBjb21lIGluIGFnYWluIGFuZCBtYXNrcyB0aGUgbGluZSwgbGVhdmVzIGR1ZQogCSAqIHRv
IElSUVNfSU5QUk9HUkVTUyBhbmQgdGhlIGlycSBsaW5lIGlzIG1hc2tlZCBmb3JldmVyLgogCSAq
CiAJICogVGhpcyBhbHNvIHNlcmlhbGl6ZXMgdGhlIHN0YXRlIG9mIHNoYXJlZCBvbmVzaG90IGhh
bmRsZXJzCiAJICogdmVyc3VzICJkZXNjLT50aHJlYWRzX29uZXNob3QgfD0gYWN0aW9uLT50aHJl
YWRfbWFzazsiIGluCiAJICogaXJxX3dha2VfdGhyZWFkKCkuIFNlZSB0aGUgY29tbWVudCB0aGVy
ZSB3aGljaCBleHBsYWlucyB0aGUKIAkgKiBzZXJpYWxpemF0aW9uLgogCSAqLwogCWlmICh1bmxp
a2VseShpcnFkX2lycV9pbnByb2dyZXNzKCZkZXNjLT5pcnFfZGF0YSkpKSB7CiAJCXJhd19zcGlu
X3VubG9ja19pcnEoJmRlc2MtPmxvY2spOwogCQljaGlwX2J1c19zeW5jX3VubG9jayhkZXNjKTsK
IAkJY3B1X3JlbGF4KCk7CisJCSsrYWdhaW5fY291bnQ7CisJCWlmIChhZ2Fpbl9jb3VudCA+IDEw
MCkgeworCQkJZm9yIChpPTA7IGkgPCA1MDsgKytpKSB7CisJCQkJY3B1X3JlbGF4KCk7CisJCQl9
CisJCX0KIAkJZ290byBhZ2FpbjsKIAl9CiAKIAkvKgogCSAqIE5vdyBjaGVjayBhZ2Fpbiwgd2hl
dGhlciB0aGUgdGhyZWFkIHNob3VsZCBydW4uIE90aGVyd2lzZQogCSAqIHdlIHdvdWxkIGNsZWFy
IHRoZSB0aHJlYWRzX29uZXNob3QgYml0IG9mIHRoaXMgdGhyZWFkIHdoaWNoCiAJICogd2FzIGp1
c3Qgc2V0LgogCSAqLwogCWlmICh0ZXN0X2JpdChJUlFURl9SVU5USFJFQUQsICZhY3Rpb24tPnRo
cmVhZF9mbGFncykpCiAJCWdvdG8gb3V0X3VubG9jazsKIAogCWRlc2MtPnRocmVhZHNfb25lc2hv
dCAmPSB+YWN0aW9uLT50aHJlYWRfbWFzazsKIAo=

--_003_AS1PR10MB56750EFD7BEA779D033A68CBEB849AS1PR10MB5675EURP_--
