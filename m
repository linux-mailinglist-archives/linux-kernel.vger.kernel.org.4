Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CEA601096
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJQN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJQN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:56:10 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F9543C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vjM5T/umQomaJfJd1VTqV5Ob6LgVqxDpkM6HPlt5aDM=;
  b=niVM0gwwxg49JNbeXMiL0veR2rtzDfG/opSFHOHuhkK70g7XyeUu0XlO
   Y7QvCxunQN+PWSBLftgBc1fktvYVOPMpFsKcWt95QaXx2GQzykGAfSkPy
   5FT/Q8QOR7kUOaELqtjRxwax0ccueROpieZsXoT2u5GVjjWIlcQZdu+4G
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,191,1661810400"; 
   d="scan'208";a="65537639"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:56:03 +0200
Date:   Mon, 17 Oct 2022 15:56:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH 1/4] staging: r8188eu: use Linux kernel variable naming
 convention
In-Reply-To: <3088d91e9d279d4515cd086ae969f33a7c061652.1666011479.git.drv@mailo.com>
Message-ID: <alpine.DEB.2.22.394.2210171554470.16433@hadrien>
References: <cover.1666011479.git.drv@mailo.com> <3088d91e9d279d4515cd086ae969f33a7c061652.1666011479.git.drv@mailo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2022, Deepak R Varma wrote:

> Follow Linux Kernel coding style variable naming convention instead of using

Follow -> Follow the

> camelCase style. Address following checkpatch script complaints:

Address following -> Address the following

> 	CHECK: Avoid CamelCase: <tagLen>
> 	CHECK: Avoid CamelCase: <tagType>
> 	CHECK: Avoid CamelCase: <networkAddr>
> 	CHECK: Avoid CamelCase: <ipAddr>
> 	CHECK: Avoid CamelCase: <macAddr>

Copy pasting the checkpatch output doesn't really need necessary.  You
could just say This affects the variables bla, bla', bla'', etc.

julia

> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 112 +++++++++++-----------
>  1 file changed, 56 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 4c5f30792a46..79daf8f269d6 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -50,17 +50,17 @@
>  static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned short type)
>  {
>  	unsigned char *cur_ptr, *start_ptr;
> -	unsigned short tagLen, tagType;
> +	unsigned short tag_len, tag_type;
>
>  	start_ptr = (unsigned char *)ph->tag;
>  	cur_ptr = (unsigned char *)ph->tag;
>  	while ((cur_ptr - start_ptr) < ntohs(ph->length)) {
>  		/*  prevent un-alignment access */
> -		tagType = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
> -		tagLen  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
> -		if (tagType == type)
> +		tag_type = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
> +		tag_len  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
> +		if (tag_type == type)
>  			return cur_ptr;
> -		cur_ptr = cur_ptr + TAG_HDR_LEN + tagLen;
> +		cur_ptr = cur_ptr + TAG_HDR_LEN + tag_len;
>  	}
>  	return NULL;
>  }
> @@ -111,32 +111,32 @@ static int  __nat25_has_expired(struct nat25_network_db_entry *fdb)
>  	return 0;
>  }
>
> -static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
> -				unsigned int *ipAddr)
> +static void __nat25_generate_ipv4_network_addr(unsigned char *network_addr,
> +				unsigned int *ip_addr)
>  {
> -	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
> +	memset(network_addr, 0, MAX_NETWORK_ADDR_LEN);
>
> -	networkAddr[0] = NAT25_IPV4;
> -	memcpy(networkAddr + 7, (unsigned char *)ipAddr, 4);
> +	network_addr[0] = NAT25_IPV4;
> +	memcpy(network_addr + 7, (unsigned char *)ip_addr, 4);
>  }
>
> -static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
> +static void __nat25_generate_pppoe_network_addr(unsigned char *network_addr,
>  				unsigned char *ac_mac, __be16 *sid)
>  {
> -	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
> +	memset(network_addr, 0, MAX_NETWORK_ADDR_LEN);
>
> -	networkAddr[0] = NAT25_PPPOE;
> -	memcpy(networkAddr + 1, (unsigned char *)sid, 2);
> -	memcpy(networkAddr + 3, (unsigned char *)ac_mac, 6);
> +	network_addr[0] = NAT25_PPPOE;
> +	memcpy(network_addr + 1, (unsigned char *)sid, 2);
> +	memcpy(network_addr + 3, (unsigned char *)ac_mac, 6);
>  }
>
> -static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
> -				unsigned int *ipAddr)
> +static  void __nat25_generate_ipv6_network_addr(unsigned char *network_addr,
> +				unsigned int *ip_addr)
>  {
> -	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
> +	memset(network_addr, 0, MAX_NETWORK_ADDR_LEN);
>
> -	networkAddr[0] = NAT25_IPV6;
> -	memcpy(networkAddr + 1, (unsigned char *)ipAddr, 16);
> +	network_addr[0] = NAT25_IPV6;
> +	memcpy(network_addr + 1, (unsigned char *)ip_addr, 16);
>  }
>
>  static unsigned char *scan_tlv(unsigned char *data, int len, unsigned char tag, unsigned char len8b)
> @@ -200,40 +200,40 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
>  	return 0;
>  }
>
> -static int __nat25_network_hash(unsigned char *networkAddr)
> +static int __nat25_network_hash(unsigned char *network_addr)
>  {
> -	if (networkAddr[0] == NAT25_IPV4) {
> +	if (network_addr[0] == NAT25_IPV4) {
>  		unsigned long x;
>
> -		x = networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
> +		x = network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
>
>  		return x & (NAT25_HASH_SIZE - 1);
> -	} else if (networkAddr[0] == NAT25_IPX) {
> +	} else if (network_addr[0] == NAT25_IPX) {
>  		unsigned long x;
>
> -		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^
> -			networkAddr[6] ^ networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
> +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> +			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
>
>  		return x & (NAT25_HASH_SIZE - 1);
> -	} else if (networkAddr[0] == NAT25_APPLE) {
> +	} else if (network_addr[0] == NAT25_APPLE) {
>  		unsigned long x;
>
> -		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3];
> +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3];
>
>  		return x & (NAT25_HASH_SIZE - 1);
> -	} else if (networkAddr[0] == NAT25_PPPOE) {
> +	} else if (network_addr[0] == NAT25_PPPOE) {
>  		unsigned long x;
>
> -		x = networkAddr[0] ^ networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^ networkAddr[6] ^ networkAddr[7] ^ networkAddr[8];
> +		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8];
>
>  		return x & (NAT25_HASH_SIZE - 1);
> -	} else if (networkAddr[0] == NAT25_IPV6) {
> +	} else if (network_addr[0] == NAT25_IPV6) {
>  		unsigned long x;
>
> -		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^
> -			networkAddr[6] ^ networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10] ^
> -			networkAddr[11] ^ networkAddr[12] ^ networkAddr[13] ^ networkAddr[14] ^ networkAddr[15] ^
> -			networkAddr[16];
> +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> +			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10] ^
> +			network_addr[11] ^ network_addr[12] ^ network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
> +			network_addr[16];
>
>  		return x & (NAT25_HASH_SIZE - 1);
>  	} else {
> @@ -241,7 +241,7 @@ static int __nat25_network_hash(unsigned char *networkAddr)
>  		int i;
>
>  		for (i = 0; i < MAX_NETWORK_ADDR_LEN; i++)
> -			x ^= networkAddr[i];
> +			x ^= network_addr[i];
>
>  		return x & (NAT25_HASH_SIZE - 1);
>  	}
> @@ -269,17 +269,17 @@ static void __network_hash_unlink(struct nat25_network_db_entry *ent)
>  }
>
>  static void __nat25_db_network_insert(struct adapter *priv,
> -				unsigned char *macAddr, unsigned char *networkAddr)
> +				unsigned char *mac_addr, unsigned char *network_addr)
>  {
>  	struct nat25_network_db_entry *db;
>  	int hash;
>
>  	spin_lock_bh(&priv->br_ext_lock);
> -	hash = __nat25_network_hash(networkAddr);
> +	hash = __nat25_network_hash(network_addr);
>  	db = priv->nethash[hash];
>  	while (db) {
> -		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
> -			memcpy(db->macAddr, macAddr, ETH_ALEN);
> +		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN)) {
> +			memcpy(db->macAddr, mac_addr, ETH_ALEN);
>  			db->ageing_timer = jiffies;
>  			spin_unlock_bh(&priv->br_ext_lock);
>  			return;
> @@ -291,8 +291,8 @@ static void __nat25_db_network_insert(struct adapter *priv,
>  		spin_unlock_bh(&priv->br_ext_lock);
>  		return;
>  	}
> -	memcpy(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN);
> -	memcpy(db->macAddr, macAddr, ETH_ALEN);
> +	memcpy(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN);
> +	memcpy(db->macAddr, mac_addr, ETH_ALEN);
>  	atomic_set(&db->use_count, 1);
>  	db->ageing_timer = jiffies;
>
> @@ -366,7 +366,7 @@ void nat25_db_expire(struct adapter *priv)
>  int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  {
>  	unsigned short protocol;
> -	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
> +	unsigned char network_addr[MAX_NETWORK_ADDR_LEN];
>  	unsigned int tmp;
>
>  	if (!skb)
> @@ -395,9 +395,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			if (iph->saddr == 0)
>  				return 0;
>  			tmp = be32_to_cpu(iph->saddr);
> -			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
> +			__nat25_generate_ipv4_network_addr(network_addr, &tmp);
>  			/* record source IP address and , source mac address into db */
> -			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
> +			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, network_addr);
>  			return 0;
>  		default:
>  			return -1;
> @@ -421,8 +421,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			memcpy(arp_ptr, GET_MY_HWADDR(priv), ETH_ALEN);
>  			arp_ptr += arp->ar_hln;
>  			sender = (unsigned int *)arp_ptr;
> -			__nat25_generate_ipv4_network_addr(networkAddr, sender);
> -			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
> +			__nat25_generate_ipv4_network_addr(network_addr, sender);
> +			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, network_addr);
>  			return 0;
>  		default:
>  			return -1;
> @@ -495,9 +495,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  					return -1;
>  				}
>  			} else {	/*  session phase */
> -				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
> +				__nat25_generate_pppoe_network_addr(network_addr, skb->data, &ph->sid);
>
> -				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
> +				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, network_addr);
>
>  				if (!priv->ethBrExtInfo.addPPPoETag &&
>  				    priv->pppoe_connection_in_progress &&
> @@ -548,8 +548,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>  			return -1;
>  		case NAT25_INSERT:
>  			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
> -				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
> -				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
> +				__nat25_generate_ipv6_network_addr(network_addr, (unsigned int *)&iph->saddr);
> +				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, network_addr);
>
>  				if (iph->nexthdr == IPPROTO_ICMPV6 &&
>  						skb->len > (ETH_HLEN +  sizeof(*iph) + 4)) {
> @@ -639,17 +639,17 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  	}
>  }
>
> -void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr)
> +void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
>  {
> -	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
> +	unsigned char network_addr[MAX_NETWORK_ADDR_LEN];
>  	struct nat25_network_db_entry *db;
>  	int hash;
>
> -	__nat25_generate_ipv4_network_addr(networkAddr, (unsigned int *)ipAddr);
> -	hash = __nat25_network_hash(networkAddr);
> +	__nat25_generate_ipv4_network_addr(network_addr, (unsigned int *)ip_addr);
> +	hash = __nat25_network_hash(network_addr);
>  	db = priv->nethash[hash];
>  	while (db) {
> -		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
> +		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN)) {
>  			return (void *)db;
>  		}
>
> --
> 2.30.2
>
>
>
>
>
