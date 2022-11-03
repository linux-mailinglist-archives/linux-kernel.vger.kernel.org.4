Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F14617E08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiKCNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKCNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:38:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC3140F2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5CDuMRI2Zvay+SEXuf7ZeO/4qtA/aYzAHJa7s3Ga7y3gKGKlaJsTtx0cpYmlG2xK4+eomzARik8xhUFSmYUbQu9JbFB7xb0pGH605o4P/KhjJkc3WZHcDknpImtKS+1HvlYHdBz7B7k48iwxqfFPyYg05q0ydt5GqTfBz9zMljZeRNMztu3Dkki+75VLKKdLQFWHpCiHUZVRrC6Qf5udFC4SwIspohjzZAt99fvPwX5357kpEFSWON3z0PQPkA4d38cA42ciA0bjuwfo0roOdx5MU8NqQR6Rs9vlFkaxV+pCvyMHfaSoidZ2ZtjYo9D3Nhp9mjnhjhxWRKTuPRGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfPlsqr5AtPpiPki5rWSbZySHT67nxhGfOGkd04WqFk=;
 b=fkdz+T9EuRKr/AK5bVndZt72Ro7UkSA8R/LZAs781iNVFc9DHQi19i9kV7LZ3Zcz0zVn9luNx/j/8buzVrPwGDAfmBbdLmSf8rMXQzG1X1IlnHd03R+zLMYNl53JRx6f331N9d+0lFxZoZgTzBJH0EbxgF7pHqbUm/Nb9LVPTQ7g1Cg+Vf4ytl1mR/0JnpVATyOq2Y6m36Yh6dgz2WAWfx0qYSUpv4m66VfGZ01QTdE0GDHrRPzHCzoIAWtfby7rlfJtx5STGRIY1OFCBm6LoQXoa6vlHgyTrHXKWBO+SQz9EPLs9fojYSa+N4KFEgmGjMD0ptH8gMylsvTdWaysvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfPlsqr5AtPpiPki5rWSbZySHT67nxhGfOGkd04WqFk=;
 b=YxmTjKj0GifexNdvth5/hVc9kQ0sQ52Fpa8oUFEPNhb4TSvLIAfkXJR0Ncu02UcIsgm8Rrmbb0d4Z8l6YILcaEU6LBHJLTQs9v4MUtUWqE8LmlpTb0cPkb8VHrl8yKKFOLgoh+e3DG3RDfjbAHez3CkY+pM5VHqByum0ESmFuRbrKyKTV08tMVviN1fvMRDMz0/GioiIFO5J4jJwcUIRnh1qddeR38EjNwVkkqGTyrvdA6fEj2IDDEyg99VqFrXz1M0es62qJw8WEuhiIyhBWZkrGxWtinUavxDg34hEdd0yNrb0qvAvD6EEcNmKBc8sLcSXb3hZH5dhN6o14Ept9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBAPR04MB7479.eurprd04.prod.outlook.com (2603:10a6:10:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 13:38:09 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 13:38:09 +0000
Message-ID: <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
Date:   Thu, 3 Nov 2022 14:38:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <jane.malalane@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org, LKML <linux-kernel@vger.kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220729070416.23306-1-jane.malalane@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DBAPR04MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f438a99-6dc3-4ffc-0b4a-08dabda0a575
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 855uxulNX1IZZ3wIgTEhzQlEI/4NZgxFvpF23Ns0Vs7i4dYGSp8v+NsSpKTanR05u5oq5k2Qt0MYPhJhd+H2b2FyEhr8m8npC5eC/UxpV714cz6txvra2hHJdieb+fT4v8Dd+kFqNi5A6DyH5XsLhcZVGm5KA5ZozhJz25iUaosMh6l62sRLBdtWBZrAC3G3/WGYhYpMQKhopbVSMrZD8doWWNaWUbTVwztQ0d4whkzLYDxcSLM+UY8Jqwx1IWwxSnMXBBcfbYOkX56lz3sAwF4Uyms1chWNgmgM6A9wChDpK2uK2ItL3lc0pQ8//EoWHmAmlitqvWZb4zwTW8GpF0Hk+Tvg31oBT1goQ8GgKG1HH/9MRxtGWGrMqEgc1iG9t5cIPFWVHfOohpvtQRMLr421WNcf23ocifyeV/sfcNO2DE5mZP1+pa+lysaFkHDxD0coSR4YAwLcszfBB9QyFh1bKqrZd0R3PvHB17tCRvSkvc89slGE6lZ9gF03buHyybkbQPP2Tem2n38j4qb3H6ZiyDAqaS242QidvQTJ3Yl+r+M7IObbDwGB7dhtET1cPwzSknUT5KjMlSkps+Z4Ud95mYU0N5gU4sw4Wm858fJC5fZxfRUZWqlEXiOeo79fW+PXf1CC/T1Si98QaSJ3+nNWLgY4Gzo5AqwYpnTFA6PUJixjZY4qCMwWBs+hYrpeqAeAzYfIR6hA1RiVTFQYkS91ZPX3pKhJMXdDbrGa5BKEnoLpGEtn18GWjHVro5sp86T2L6RdW3IYAn7dkxpI1Zinpuv2aCS8/5NU23M3ukc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(66899015)(6486002)(6506007)(2616005)(66476007)(2906002)(66556008)(66946007)(53546011)(7416002)(41300700001)(5660300002)(26005)(4326008)(8676002)(6512007)(8936002)(186003)(31696002)(83380400001)(38100700002)(54906003)(316002)(86362001)(31686004)(6916009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpDMFptaHF1d1pxOWRYeVQ1Sk5uNk9rSGRDZU5iM1oxMDdya0tXMkpBa204?=
 =?utf-8?B?Skg0QS9NUlZ3eUZqVUhVRWRTRUoxa0hZMzRneGpkOFhpVEhrVWpRUlNZWHhZ?=
 =?utf-8?B?eFg1SDQ3T2p6ZTNGZ0RnVkdzUlBReXh2VFQrWk5uTGtaVGhPQUVSN0tYOWdv?=
 =?utf-8?B?NGJGUWsyVzRTY1NhdVlUNCttb3BKREdyQk5XblJyZXYxVUdidFhrUG12cUsr?=
 =?utf-8?B?MS9wNXd2V1JQSVVDRkxhT0c3ZTdHYy9MYzlFU3VPZkVGaXhsdEpmRWI0SHN3?=
 =?utf-8?B?ZTFSUXkrdE1YSm1VUVNsNHRDZk9vbERFdlNzRmFqNWNFci93UmxncmNVYUhZ?=
 =?utf-8?B?VVVQdWZvdm1aMUlNSDlBVzNxaTZPalNZVFpwcXpEUGNzclBxdHZGR2VjeC9E?=
 =?utf-8?B?a1hpaGlmMlFOcTdQam8zay80Q1RnS2g4VkVIVk9TZVBGTjBEM2d0M2J2RkUw?=
 =?utf-8?B?UDNXNVcwZUplZWRTbi9VNEJNem00TjBzbFF2QmpkV3dnM1NadndlQlZwa1Vw?=
 =?utf-8?B?NU1VWkFnK3JBdXh6bmhpU3Z3UXBwbi9JVk1EelI1UEdZeWRldVRWcUlCRzU5?=
 =?utf-8?B?Y2JIL2hqYnFBRXlzTVBUSHUwNzczZjJONHdVOXNWZ3J2UzdZTUNCL1Jpc3lZ?=
 =?utf-8?B?bTJKRjViMThmNlA0NU5VSU8wMHVqOUUzSlcva3dBdk9TWjg1cGtPc1ZXQmVU?=
 =?utf-8?B?My9MNGVBKzIrSTg5dkxtZDY0clR2M0FBSDBnNWYwaVlCY0k1dWF1SXFybFY4?=
 =?utf-8?B?WGxva3B1Rmk2UVR6OURPekpvWS9jNGk0dEdYUTRRcEgzNnJHd1BlNVoycUhz?=
 =?utf-8?B?S2ZsSnNwY1FNRm1FdEkzZS9PaXpsVHhMYWhFbDk2YVVXUGVVRHU5eEZoWVJs?=
 =?utf-8?B?MlExc3Z1SmNYV3RWNi9SeHpDN0ZDU2lvZDRNQVhMclVnMllHRnZsNkhaRHFS?=
 =?utf-8?B?dGNyOG1IblFicXI1b25DVHFldFROd0VXYzdQc3J4dER6dDNRUWt4ai9rM21x?=
 =?utf-8?B?N3pjOTVRcC9hU3BOWnlSRkYxdkg5YmRZYUZtZEgwVnpmMGhQMGMwa3N5aDVn?=
 =?utf-8?B?eVVBR0RnUm8xV3ZFU0pmZnQ1blArNnNGYTY0L3V0TTVBczlxMGFtME53Qi9C?=
 =?utf-8?B?aDdUYTliU1p2VksxSWFjZGZlY0dKSC82Z2VCU3pxK3dBNWtlR0hkdHUzcE1j?=
 =?utf-8?B?azMvSHhLVFUxSldod0MwdzFwQmhDekQrQWRPZ1RHblJvWmVucXBXZ1c1eGE4?=
 =?utf-8?B?RXgraytpS1RORktxdTVQa255eUhUd3hhYkgvNStocUl6UytmSHYyS1lNVjFI?=
 =?utf-8?B?SFRRM01hczJjRWtrM0RzdVpGQWI0S29abVVTRXN4UXhrdytlWHVYSGdUY1p6?=
 =?utf-8?B?dGE4bXByMEZraCtKcDE1bHhuOVl3TVU5cUtRSXJ2Z2JTTFR3V1FpenFuMU1S?=
 =?utf-8?B?NWdaSk9pWWxPempOYjFaTHF1TEt1SVFVWno0U0pDT0VmaEp0dlVyZWJnMGtt?=
 =?utf-8?B?US9hVlVTb2RLV1VKOVNLemk4V2VFZ3Q2Z2MrbWlSbVNTMWk4Znp3Rk9Kbmhj?=
 =?utf-8?B?Y0ZyaGJiRFFBd21uUkRJR2RKbjRqYnVvYUMwZWx6K2ptYklVcmVGQncycXU0?=
 =?utf-8?B?UXlqRW1Ea3hQLytKcHRxVjVwU0xOYUQrTytFR28wNEkvclk3TUtnRXRZODlM?=
 =?utf-8?B?MlVobkQ3d3c4MTk5WDR0OUI3eVB6Ukg3NndZRGRBenY4SFQva2RxMFNRRjFM?=
 =?utf-8?B?WHNrSjNMSjhaZk9OVVd1S3FKcTFLUlBmWHNFUFpta2liZm1UZndiWHlCTElJ?=
 =?utf-8?B?LzczYS90MGxBcWtxU3NBQWdvQnF3aU1UVG9Oc1hkcW5TZlhHN3JLYnI1SDE3?=
 =?utf-8?B?NXFwalFPVWhpbXpxQ0F1d2E0NmdnTWpSeGhGYU1kdG1Xc3dDbjExb1hrdDhT?=
 =?utf-8?B?MjZnajFIQXpxckRsb3RTeVN3RitONGREY0p5a1pVZnNGMkFCdjlSRUF3N2xS?=
 =?utf-8?B?cE5zN2h2T25abFE1VGVkUmRkSlhxRkhQTnJGUFpxQTVSUXArY20vN1k2eW1P?=
 =?utf-8?B?ajljL1lHckNkRXM4UnR5TnMzL0d4NThUVnA2Tk45a282YnNzZFFPYnB5ak5p?=
 =?utf-8?Q?TxemHabsi/L4YNT6uNIqwJYtO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f438a99-6dc3-4ffc-0b4a-08dabda0a575
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 13:38:09.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS5b3e/8f3kjUo6tQodGbGEJk4Czbt+2SmMhDGtCUfWa5jyosncZBNLSScEE8eMOAAchCvnsct3gu4iSMPv+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.2022 09:04, Jane Malalane wrote:
> @@ -125,6 +130,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
> +	if (xen_percpu_upcall)
> +		ack_APIC_irq();
> +
>  	inc_irq_stat(irq_hv_callback_count);
>  
>  	xen_hvm_evtchn_do_upcall();
> @@ -168,6 +176,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>  	if (!xen_have_vector_callback)
>  		return 0;
>  
> +	if (xen_percpu_upcall) {
> +		rc = xen_set_upcall_vector(cpu);

From all I can tell at least for APs this happens before setup_local_apic().
With there being APIC interaction in this operation mode, as seen e.g. in
the earlier hunk above, I think this is logically wrong. And it leads to
apic_pending_intr_clear() issuing its warning: The vector registration, as
an intentional side effect, marks the vector as pending. Unless IRQs were
enabled at any point between the registration and the check, there's
simply no way for the corresponding IRR bit to be dealt with (by
propagating to ISR when the interrupt is delivered, and then being cleared
from ISR by EOI).

As a note to x86 maintainers: This comment there

	/*
	 * If the ISR map is not empty. ACK the APIC and run another round
	 * to verify whether a pending IRR has been unblocked and turned
	 * into a ISR.
	 */

is pretty clearly wrong - with IRQs disabled there's no way for a pending
IRR bit to be "unblocked and turned into a ISR" one. And even if IRQs
were enabled TPR would still prevent the handling of any bits potentially
set in the 16....31 range.

Jan
