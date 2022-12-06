Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A1643D18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLFGVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLFGVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:21:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549E2715C;
        Mon,  5 Dec 2022 22:21:12 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B66BFvF003669;
        Tue, 6 Dec 2022 06:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ld8PbuFHcp19Kv6pxwvU4ryNo8XlLtBFYlmJeDNGim0=;
 b=MVQTxvC6L/REiuECwxNng8L4a2WyqOyu/zI1PgJPgn/F3RP1ciGSM+rdMEq0brXQrgOz
 GeCX6jj53eXOMykIHdz91YKydg0RwYkerK9pkmNq29BRccMVJov7MLk4EBf7D3FPCEuw
 73oYkaVv81RMe0sLYO7I5U1BhN1dKv8AzoWWsyLWk5oZOjUWTawrDRK2cj5ZKffrG1HU
 NaLm9zL8E+KcMBMpzg+gV9JFMrtYimEPhR3O45hJBJrZ/DzqpwPmTKD67l39g8WVWEDC
 e3kJ8UrAwrf+WWGRkvCXI7B0t7hsaKTMhRguE0xrP6OMC5E4TyEgQM1nMQcKCeH/Xqqz 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8ga7saxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:20:54 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B669ik6001675;
        Tue, 6 Dec 2022 06:20:54 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8ga7sawm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:20:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5K5Cr6011960;
        Tue, 6 Dec 2022 06:20:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3m9mb20nk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 06:20:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com ([9.149.105.232])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B66KnPa33620304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 06:20:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D04565204F;
        Tue,  6 Dec 2022 06:20:49 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5114F5204E;
        Tue,  6 Dec 2022 06:20:49 +0000 (GMT)
Message-ID: <d33354c9-810e-0577-86b5-20552718f8a0@linux.ibm.com>
Date:   Tue, 6 Dec 2022 07:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] cxl: Remove unnecessary cxl_pci_window_alignment()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20221205223231.1268085-1-helgaas@kernel.org>
Content-Language: en-US
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20221205223231.1268085-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r6lMV4U7gNDYUcEmMW9vIUIzs1R1eJTb
X-Proofpoint-ORIG-GUID: fgRxZnZTWhP6dLlTx-yrlREiRfBluUki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_03,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060049
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/2022 23:32, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> cxl_pci_window_alignment() is referenced only via the struct
> pci_controller_ops.window_alignment function pointer, and only in the
> powerpc implementation of pcibios_window_alignment().
> 
> pcibios_window_alignment() defaults to returning 1 if the function pointer
> is NULL, which is the same was what cxl_pci_window_alignment() does.
> 
> cxl_pci_window_alignment() is unnecessary, so remove it.  No functional
> change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---


Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   drivers/misc/cxl/vphb.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 1264253cc07b..6332db8044bd 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -67,12 +67,6 @@ static void cxl_pci_disable_device(struct pci_dev *dev)
>   	}
>   }
>   
> -static resource_size_t cxl_pci_window_alignment(struct pci_bus *bus,
> -						unsigned long type)
> -{
> -	return 1;
> -}
> -
>   static void cxl_pci_reset_secondary_bus(struct pci_dev *dev)
>   {
>   	/* Should we do an AFU reset here ? */
> @@ -200,7 +194,6 @@ static struct pci_controller_ops cxl_pci_controller_ops =
>   	.enable_device_hook = cxl_pci_enable_device_hook,
>   	.disable_device = cxl_pci_disable_device,
>   	.release_device = cxl_pci_disable_device,
> -	.window_alignment = cxl_pci_window_alignment,
>   	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
>   	.setup_msi_irqs = cxl_setup_msi_irqs,
>   	.teardown_msi_irqs = cxl_teardown_msi_irqs,
