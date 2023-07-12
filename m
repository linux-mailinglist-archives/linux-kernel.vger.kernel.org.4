Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34542750834
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjGLM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjGLM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:26:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0579B;
        Wed, 12 Jul 2023 05:26:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CCQ45f076103;
        Wed, 12 Jul 2023 07:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689164764;
        bh=2+TJV7UTEfg4twrLPPlTtGNNmrMyxqIzMxApzACFHn8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vgrvu5/QLnSnojItGoa7E7Wq1AClMgEqRoXk8s+kglmq9wKte1/oQ0Ml1LuK+KRV0
         K+3+uF8dLc9wCt+Mpzw1XbRYDQ6knD0LfGXOIRstX/laT8yLCtxmPoPQqGfpm5I0LI
         MwiMGEcGPadMOpmgIWMZPRcYBf/t6Ls8+d9KoL6U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CCQ4Rb007083
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 07:26:04 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 07:26:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 07:26:04 -0500
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CCPwdO053774;
        Wed, 12 Jul 2023 07:25:58 -0500
Message-ID: <afbd4c9d-5ff7-e366-f866-6b718907d6fa@ti.com>
Date:   Wed, 12 Jul 2023 17:55:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v8 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710053550.89160-1-danishanwar@ti.com>
 <20230710053550.89160-3-danishanwar@ti.com> <ZK2VRYwW8DxIZCY2@corigine.com>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <ZK2VRYwW8DxIZCY2@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon
On 7/11/2023 11:15 PM, Simon Horman wrote:
> On Mon, Jul 10, 2023 at 11:05:50AM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> This is the Ethernet driver for TI AM654 Silicon rev. 2
>> with the ICSSG PRU Sub-system running dual-EMAC firmware.
>>
>> The Programmable Real-time Unit and Industrial Communication Subsystem
>> Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
>> SoCs. This subsystem is provided for the use cases like implementation of
>> custom peripheral interfaces, offloading of tasks from the other
>> processor cores of the SoC, etc.
>>
>> Every ICSSG core has two Programmable Real-Time Unit(PRUs),
>> two auxiliary Real-Time Transfer Unit (RT_PRUs), and
>> two Transmit Real-Time Transfer Units (TX_PRUs). Each one of these runs
>> its own firmware. Every ICSSG core has two MII ports connect to these
>> PRUs and also a MDIO port.
>>
>> The cores can run different firmwares to support different protocols and
>> features like switch-dev, timestamping, etc.
>>
>> It uses System DMA to transfer and receive packets and
>> shared memory register emulation between the firmware and
>> driver for control and configuration.
>>
>> This patch adds support for basic EMAC functionality with 1Gbps
>> and 100Mbps link speed. 10M and half duplex mode are not supported
>> currently as they require IEP, the support for which will be added later.
>> Support for switch-dev, timestamp, etc. will be added later
>> by subsequent patch series.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> [Vignesh Raghavendra: add 10M full duplex support]
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> [Grygorii Strashko: add support for half duplex operation]
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> ...
> 
>> +/**
>> + * struct map - ICSSG Queue Map
>> + * @queue: Queue number
>> + * @pd_addr_start: Packet descriptor queue reserved memory
>> + * @flags: Flags
>> + * @special: Indicates whether this queue is a special queue or not
>> + */
>> +struct map {
>> +	int queue;
>> +	u32 pd_addr_start;
>> +	u32 flags;
>> +	bool special;
>> +};
>> +
>> +/* Hardware queue map for ICSSG */
>> +const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
> 
> Should this be static?
> 

Yes this can be static. I will change this to static.

>> +	{
>> +		{ PORT_HI_Q_SLICE0, PORT_DESC0_HI, 0x200000, 0 },
>> +		{ PORT_LO_Q_SLICE0, PORT_DESC0_LO, 0, 0 },
>> +		{ HOST_HI_Q_SLICE0, HOST_DESC0_HI, 0x200000, 0 },
>> +		{ HOST_LO_Q_SLICE0, HOST_DESC0_LO, 0, 0 },
>> +		{ HOST_SPL_Q_SLICE0, HOST_SPPD0, 0x400000, 1 },
>> +	},
>> +	{
>> +		{ PORT_HI_Q_SLICE1, PORT_DESC1_HI, 0xa00000, 0 },
>> +		{ PORT_LO_Q_SLICE1, PORT_DESC1_LO, 0x800000, 0 },
>> +		{ HOST_HI_Q_SLICE1, HOST_DESC1_HI, 0xa00000, 0 },
>> +		{ HOST_LO_Q_SLICE1, HOST_DESC1_LO, 0x800000, 0 },
>> +		{ HOST_SPL_Q_SLICE1, HOST_SPPD1, 0xc00000, 1 },
>> +	},
>> +};
>> +
>> +static void icssg_config_mii_init(struct prueth_emac *emac)
>> +{
>> +	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
>> +	struct prueth *prueth = emac->prueth;
>> +	int slice = prueth_emac_slice(emac);
>> +	struct regmap *mii_rt;
>> +
>> +	mii_rt = prueth->mii_rt;
>> +
>> +	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
>> +				       PRUSS_MII_RT_RXCFG1;
>> +	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
>> +				       PRUSS_MII_RT_TXCFG1;
>> +	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
>> +				       PRUSS_MII_RT_RX_PCNT1;
>> +
>> +	rxcfg = MII_RXCFG_DEFAULT;
>> +	txcfg = MII_TXCFG_DEFAULT;
>> +
>> +	if (slice == ICSS_MII1)
>> +		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
>> +
>> +	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
>> +	 * to be swapped also comparing to RGMII mode.
>> +	 */
>> +	if (emac->phy_if == PHY_INTERFACE_MODE_MII && slice == ICSS_MII0)
>> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>> +	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
>> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
>> +
>> +	regmap_write(mii_rt, rxcfg_reg, rxcfg);
>> +	regmap_write(mii_rt, txcfg_reg, txcfg);
>> +	regmap_write(mii_rt, pcnt_reg, 0x1);
>> +}
>> +
>> +static void icssg_miig_queues_init(struct prueth *prueth, int slice)
>> +{
>> +	struct regmap *miig_rt = prueth->miig_rt;
>> +	void __iomem *smem = prueth->shram.va;
>> +	u8 pd[ICSSG_SPECIAL_PD_SIZE];
>> +	int queue = 0, i, j;
>> +	u32 *pdword;
>> +
>> +	/* reset hwqueues */
>> +	if (slice)
>> +		queue = ICSSG_NUM_TX_QUEUES;
>> +
>> +	for (i = 0; i < ICSSG_NUM_TX_QUEUES; i++) {
>> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
>> +		queue++;
>> +	}
>> +
>> +	queue = slice ? RECYCLE_Q_SLICE1 : RECYCLE_Q_SLICE0;
>> +	regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
>> +
>> +	for (i = 0; i < ICSSG_NUM_OTHER_QUEUES; i++) {
>> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET,
>> +			     hwq_map[slice][i].queue);
>> +	}
>> +
>> +	/* initialize packet descriptors in SMEM */
>> +	/* push pakcet descriptors to hwqueues */
>> +
>> +	pdword = (u32 *)pd;
>> +	for (j = 0; j < ICSSG_NUM_OTHER_QUEUES; j++) {
>> +		const struct map *mp;
>> +		int pd_size, num_pds;
>> +		u32 pdaddr;
>> +
>> +		mp = &hwq_map[slice][j];
>> +		if (mp->special) {
>> +			pd_size = ICSSG_SPECIAL_PD_SIZE;
>> +			num_pds = ICSSG_NUM_SPECIAL_PDS;
>> +		} else	{
>> +			pd_size = ICSSG_NORMAL_PD_SIZE;
>> +			num_pds = ICSSG_NUM_NORMAL_PDS;
>> +		}
>> +
>> +		for (i = 0; i < num_pds; i++) {
>> +			memset(pd, 0, pd_size);
>> +
>> +			pdword[0] &= cpu_to_le32(ICSSG_FLAG_MASK);
>> +			pdword[0] |= cpu_to_le32(mp->flags);
> 
> Sparse warns that the endieness of pdword is not le32.

I will fix this.

> There are also other sparse warnings added by this patch.
> Please look over them.

There is one more warning for "expected restricted __le16 [usertype] 
rx_base_flow got restricted __le32 [usertype]". I will fix this as well.

There is one more sparse warning "warning: symbol 'icssg_ethtool_ops' 
was not declared. Should it be static?". This should be ignored as no 
need to change 'icssg_ethtool_ops' to static as this is decalred in 
icssg_ethtool.c and used in icssg_prueth.c

> 
>> +			pdaddr = mp->pd_addr_start + i * pd_size;
>> +
>> +			memcpy_toio(smem + pdaddr, pd, pd_size);
>> +			queue = mp->queue;
>> +			regmap_write(miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue,
>> +				     pdaddr);
>> +		}
>> +	}
>> +}
> 
> ...
> 
>> +static int prueth_netdev_init(struct prueth *prueth,
>> +			      struct device_node *eth_node)
>> +{
>> +	int ret, num_tx_chn = PRUETH_MAX_TX_QUEUES;
>> +	struct prueth_emac *emac;
>> +	struct net_device *ndev;
>> +	enum prueth_port port;
>> +	enum prueth_mac mac;
>> +
>> +	port = prueth_node_port(eth_node);
>> +	if (port < 0)
>> +		return -EINVAL;
>> +
>> +	mac = prueth_node_mac(eth_node);
>> +	if (mac < 0)
>> +		return -EINVAL;
>> +
>> +	ndev = alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
>> +	if (!ndev)
>> +		return -ENOMEM;
> 
> ...
> 
>> +	return 0;
>> +
>> +free:
>> +	pruss_release_mem_region(prueth->pruss, &emac->dram);
>> +free_wq:
>> +	destroy_workqueue(emac->cmd_wq);
>> +free_ndev:
>> +	free_netdev(ndev);
>> +	prueth->emac[mac] = NULL;
>> +
>> +	return ret;
> 
> ndev appears to be leaked here.
> 
> ...
> 
>> +	prueth->dev = dev;
>> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>> +	if (!eth_ports_node)
>> +		return -ENOENT;
>> +
>> +	for_each_child_of_node(eth_ports_node, eth_node) {
>> +		u32 reg;
>> +
>> +		if (strcmp(eth_node->name, "port"))
>> +			continue;
>> +		ret = of_property_read_u32(eth_node, "reg", &reg);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%pOF error reading port_id %d\n",
>> +				eth_node, ret);
>> +		}
>> +
>> +		of_node_get(eth_node);
>> +
>> +		if (reg == 0) {
>> +			eth0_node = eth_node;
>> +			if (!of_device_is_available(eth0_node)) {
>> +				of_node_put(eth0_node);
>> +				eth0_node = NULL;
>> +			}
>> +		} else if (reg == 1) {
>> +			eth1_node = eth_node;
>> +			if (!of_device_is_available(eth1_node)) {
>> +				of_node_put(eth1_node);
>> +				eth1_node = NULL;
>> +			}
>> +		} else {
>> +			dev_err(dev, "port reg should be 0 or 1\n");
> 
> Should this be treated as an error and either return or goto an
> unwind path?
> 

I don't think we should error out or return to any goto label here. Here 
we are checking 'reg' property in all available ports. If reg=0, we 
assign the node to eth0_node. If reg=1, we assign the node to eth1_node. 
If the reg is neither 0 nor 1, we will just keep looking through other 
available ports, instead of returning error. We will eventually look 
through all available nodes.

Once we come out of the for loop, we should at least have one node with 
reg property being either 0 or 1. If no node had reg as 0 or 1, both 
eth0_node and eth1_node will be NULL, then we will error out with 
-ENODEV error by below if check.

if (!eth0_node && !eth1_node) {
	dev_err(dev, "neither port0 nor port1 node available\n");
	return -ENODEV;
}

>> +		}
>> +	}
>> +
>> +	of_node_put(eth_ports_node);
>> +
>> +	/* At least one node must be present and available else we fail */
>> +	if (!eth0_node && !eth1_node) {
> 
> Smatch warns that eth0_node and eth1_node may be uninitialised here.
> 

Sure, I will initialise eth0_node and eth1_node as NULL.

>> +		dev_err(dev, "neither port0 nor port1 node available\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (eth0_node == eth1_node) {
>> +		dev_err(dev, "port0 and port1 can't have same reg\n");
>> +		of_node_put(eth0_node);
>> +		return -ENODEV;
>> +	}
> 
> ...
> 

-- 
Thanks and Regards,
Md Danish Anwar
