Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759A6C2C09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCUIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCUIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:12:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F101298FF;
        Tue, 21 Mar 2023 01:12:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so10563801wmb.2;
        Tue, 21 Mar 2023 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679386324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8aDzrMXQdV9J471YpQnPMGExzHql6OoocK9G5mNgnzM=;
        b=dzVn+Ae2Zyo9CxmjF9Rm2FdEWEZ75+p+aInqZaR+yZIsoicphru4jHUx8LPnFR9drp
         4DjXdDadwCuBXRKku7l4v9WydOUdJBC8Hrh1v+Uj49ouTf48SGjwuGILJgAv9F8EwdOo
         y4djaqYExOYPD1ZrHBxeDVj7U1IQNX3KmhGepumakSxybmTV9UhsYZ1FZQT30u2XEJUy
         7duXlwC5tDDm3cpavvBDI0Myl4BrKDgr7ZmVz/zCuHjUcIgkpQkj6ScLWLQ/hWw1vBBe
         ihRw6zvGa3OHkGUK73dytOfYqxWB462WubLEE+YA4jLjNUVQb7ArEnd0rgK7y0qzjkjy
         ttaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679386324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aDzrMXQdV9J471YpQnPMGExzHql6OoocK9G5mNgnzM=;
        b=1V0qSsg74cCgWdA6XmdGTdkL6stXDl/las/NKaJ7t5t4aGJTHHx2RUP7KQkV/ByJac
         ndtTVNo6fMKpJsvqxIhuKBZcOBXpWL0vsziyCdAQy7xBNlY0+CxicvIprjJEm7Z9Z4Gs
         FVDRCowttUl/+T8ELtiaRP0yzCyDwybj6L3PadqdwFxx2+DHVFTQ+DHzevcdFMC87vZW
         bUqmXTmsF7tbCP7AezBX8LjjodOZEwGk0I8bjMETq9dmHJM28jhAwunAzntLGrHGTySe
         U9lNMY8mVW2cNHljPF5B6HxGvlT4zwBxjx5TPR3bi2iie4IpQcTX9iLebOR2QBSFS/BD
         vvYg==
X-Gm-Message-State: AO0yUKUbAQu3prnMWo94nUGYJk/2EFgeI5UywMiTZBc5RdrkABSPafEy
        3n3TZEf5pga4X0mBphK2erf9dHhqcLXPEg==
X-Google-Smtp-Source: AK7set+KN4Us/vSp94x/rHx+6HRRhEssUtYVF57P0e+mtEzkVI95x4Q1Qm1GKwvXRB3LuekEMz4JcQ==
X-Received: by 2002:a1c:f603:0:b0:3eb:39e7:35fe with SMTP id w3-20020a1cf603000000b003eb39e735femr1512860wmc.30.1679386324310;
        Tue, 21 Mar 2023 01:12:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s20-20020a7bc394000000b003ee3e075d1csm538583wmj.22.2023.03.21.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 01:12:03 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:12:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Message-ID: <c38b6275-e137-4f32-9232-697b1f188494@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-gadget-Properly-configure-the-device-for-remote-wakeup/20230317-074030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1679009888-8239-7-git-send-email-quic_eserrao%40quicinc.com
patch subject: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
config: riscv-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230321/202303211515.XaO8YKCz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303211515.XaO8YKCz-lkp@intel.com/

New smatch warnings:
drivers/usb/gadget/function/u_ether.c:474 eth_start_xmit() error: we previously assumed 'dev->port_usb' could be null (see line 466)
drivers/usb/gadget/function/u_ether.c:539 eth_start_xmit() warn: variable dereferenced before check 'dev->port_usb' (see line 474)

Old smatch warnings:
drivers/usb/gadget/function/u_ether.c:553 eth_start_xmit() error: we previously assumed 'skb' could be null (see line 491)

vim +474 drivers/usb/gadget/function/u_ether.c

25a79c41ce0ce8 drivers/usb/gadget/u_ether.c          Stephen Hemminger   2009-08-31  454  static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
25a79c41ce0ce8 drivers/usb/gadget/u_ether.c          Stephen Hemminger   2009-08-31  455  					struct net_device *net)
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  456  {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  457  	struct eth_dev		*dev = netdev_priv(net);
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  458  	int			length = 0;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  459  	int			retval;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  460  	struct usb_request	*req = NULL;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  461  	unsigned long		flags;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  462  	struct usb_ep		*in;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  463  	u16			cdc_filter;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  464  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  465  	spin_lock_irqsave(&dev->lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19 @466  	if (dev->port_usb) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  467  		in = dev->port_usb->in_ep;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  468  		cdc_filter = dev->port_usb->cdc_filter;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  469  	} else {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  470  		in = NULL;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  471  		cdc_filter = 0;

NULL on this path.

2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  472  	}
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  473  
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16 @474  	if (dev->port_usb->is_suspend) {
                                                                                                    ^^^^^^^^^^^^^^^
Dead.  (Both ->port_usb warnings are caused by this dereference).

11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  475  		DBG(dev, "Port suspended. Triggering wakeup\n");
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  476  		netif_stop_queue(net);
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  477  		spin_unlock_irqrestore(&dev->lock, flags);
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  478  		ether_wakeup_host(dev->port_usb);
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  479  		return NETDEV_TX_BUSY;
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  480  	}
11f254fc796c87 drivers/usb/gadget/function/u_ether.c Elson Roy Serrao    2023-03-16  481  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  482  	spin_unlock_irqrestore(&dev->lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  483  
8ae01239609b29 drivers/usb/gadget/function/u_ether.c Maciej Żenczykowski 2021-07-01  484  	if (!in) {
8ae01239609b29 drivers/usb/gadget/function/u_ether.c Maciej Żenczykowski 2021-07-01  485  		if (skb)
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  486  			dev_kfree_skb_any(skb);
6ed106549d1747 drivers/usb/gadget/u_ether.c          Patrick McHardy     2009-06-23  487  		return NETDEV_TX_OK;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  488  	}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  489  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  490  	/* apply outgoing CDC or RNDIS filters */
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  491  	if (skb && !is_promisc(cdc_filter)) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  492  		u8		*dest = skb->data;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  493  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  494  		if (is_multicast_ether_addr(dest)) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  495  			u16	type;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  496  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  497  			/* ignores USB_CDC_PACKET_TYPE_MULTICAST and host
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  498  			 * SET_ETHERNET_MULTICAST_FILTERS requests
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  499  			 */
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  500  			if (is_broadcast_ether_addr(dest))
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  501  				type = USB_CDC_PACKET_TYPE_BROADCAST;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  502  			else
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  503  				type = USB_CDC_PACKET_TYPE_ALL_MULTICAST;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  504  			if (!(cdc_filter & type)) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  505  				dev_kfree_skb_any(skb);
6ed106549d1747 drivers/usb/gadget/u_ether.c          Patrick McHardy     2009-06-23  506  				return NETDEV_TX_OK;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  507  			}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  508  		}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  509  		/* ignores USB_CDC_PACKET_TYPE_DIRECTED */
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  510  	}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  511  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  512  	spin_lock_irqsave(&dev->req_lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  513  	/*
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  514  	 * this freelist can be empty if an interrupt triggered disconnect()
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  515  	 * and reconfigured the gadget (shutting down this queue) after the
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  516  	 * network stack decided to xmit but before we got the spinlock.
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  517  	 */
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  518  	if (list_empty(&dev->tx_reqs)) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  519  		spin_unlock_irqrestore(&dev->req_lock, flags);
5b548140225c6b drivers/usb/gadget/u_ether.c          Patrick McHardy     2009-06-12  520  		return NETDEV_TX_BUSY;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  521  	}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  522  
fea14e68ff5e11 drivers/usb/gadget/function/u_ether.c Felipe Balbi        2017-03-22  523  	req = list_first_entry(&dev->tx_reqs, struct usb_request, list);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  524  	list_del(&req->list);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  525  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  526  	/* temporarily stop TX queue when the freelist empties */
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  527  	if (list_empty(&dev->tx_reqs))
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  528  		netif_stop_queue(net);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  529  	spin_unlock_irqrestore(&dev->req_lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  530  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  531  	/* no buffer copies needed, unless the network stack did it
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  532  	 * or the hardware can't use skb buffers.
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  533  	 * or there's not enough space for extra headers we need
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  534  	 */
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  535  	if (dev->wrap) {
9b39e9ddedeef4 drivers/usb/gadget/u_ether.c          Brian Niebuhr       2009-08-14  536  		unsigned long	flags;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  537  
9b39e9ddedeef4 drivers/usb/gadget/u_ether.c          Brian Niebuhr       2009-08-14  538  		spin_lock_irqsave(&dev->lock, flags);
9b39e9ddedeef4 drivers/usb/gadget/u_ether.c          Brian Niebuhr       2009-08-14 @539  		if (dev->port_usb)
9b39e9ddedeef4 drivers/usb/gadget/u_ether.c          Brian Niebuhr       2009-08-14  540  			skb = dev->wrap(dev->port_usb, skb);
3a383cc0b8cc33 drivers/usb/gadget/function/u_ether.c Greg Kroah-Hartman  2016-09-19  541  		spin_unlock_irqrestore(&dev->lock, flags);
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  542  		if (!skb) {
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  543  			/* Multi frame CDC protocols may store the frame for
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  544  			 * later which is not a dropped frame.
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  545  			 */
88c09eacf560c3 drivers/usb/gadget/function/u_ether.c Peter Chen          2016-07-01  546  			if (dev->port_usb &&
3a383cc0b8cc33 drivers/usb/gadget/function/u_ether.c Greg Kroah-Hartman  2016-09-19  547  					dev->port_usb->supports_multi_frame)
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  548  				goto multiframe;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  549  			goto drop;
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  550  		}
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  551  	}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  552  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  553  	length = skb->len;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  554  	req->buf = skb->data;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  555  	req->context = skb;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  556  	req->complete = tx_complete;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  557  
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  558  	/* NCM requires no zlp if transfer is dwNtbInMaxSize */
79775f44183840 drivers/usb/gadget/function/u_ether.c Harish Jenny K N    2016-09-09  559  	if (dev->port_usb &&
79775f44183840 drivers/usb/gadget/function/u_ether.c Harish Jenny K N    2016-09-09  560  	    dev->port_usb->is_fixed &&
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  561  	    length == dev->port_usb->fixed_in_len &&
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  562  	    (length % in->maxpacket) == 0)
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  563  		req->zero = 0;
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  564  	else
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  565  		req->zero = 1;
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  566  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  567  	/* use zlp framing on tx for strict CDC-Ether conformance,
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  568  	 * though any robust network rx path ignores extra padding.
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  569  	 * and some hardware doesn't like to write zlps.
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  570  	 */
5c1168dbc50828 drivers/usb/gadget/u_ether.c          Yauheni Kaliuta     2010-12-08  571  	if (req->zero && !dev->zlp && (length % in->maxpacket) == 0)
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  572  		length++;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  573  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  574  	req->length = length;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  575  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  576  	retval = usb_ep_queue(in, req, GFP_ATOMIC);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  577  	switch (retval) {
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  578  	default:
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  579  		DBG(dev, "tx queue err %d\n", retval);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  580  		break;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  581  	case 0:
860e9538a9482b drivers/usb/gadget/function/u_ether.c Florian Westphal    2016-05-03  582  		netif_trans_update(net);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  583  		atomic_inc(&dev->tx_qlen);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  584  	}
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  585  
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  586  	if (retval) {
9b39e9ddedeef4 drivers/usb/gadget/u_ether.c          Brian Niebuhr       2009-08-14  587  		dev_kfree_skb_any(skb);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  588  drop:
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  589  		dev->net->stats.tx_dropped++;
6d3865f9d41f15 drivers/usb/gadget/u_ether.c          Jim Baxter          2014-07-07  590  multiframe:
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  591  		spin_lock_irqsave(&dev->req_lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  592  		if (list_empty(&dev->tx_reqs))
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  593  			netif_start_queue(net);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  594  		list_add(&req->list, &dev->tx_reqs);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  595  		spin_unlock_irqrestore(&dev->req_lock, flags);
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  596  	}
6ed106549d1747 drivers/usb/gadget/u_ether.c          Patrick McHardy     2009-06-23  597  	return NETDEV_TX_OK;
2b3d942c487808 drivers/usb/gadget/u_ether.c          David Brownell      2008-06-19  598  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

