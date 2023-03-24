Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544446C882A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCXWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:12:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74620576
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:11:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so3124696wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcvZzRz5s2MdQIy+7MD9Geaf7c7s2ujOyb3GzEulVCU=;
        b=SeY5FRnZ7chEi53v22pvitzQvGddPVHhzTD03PCkZtBrgjV1hOmD2IN6iRCIrOnRrS
         YcX84Xo4jNteqMjDhZVCtxGznd7scup+56W+G50PAPtwlctX+5XJbpGicuwhUcpbu6CM
         XXzSOJS+B4LBcETbkeLKrZXjVSEHKnEt2yAEUAcaCs2bjlRH4/SQVoK/1NjeHaRTCnuT
         w2c0cA2uFo5KCFvOg3FxRush9XbOLJKpMPz7UKlOe6yVGTt/1N2+lQxRnS8P62mPnqiE
         YKlecmZTNYAYYge23555+yHMdnVSNllxhIVG0GYgBzQPHxm7M3q/CljOeKAyaXN79xJV
         DUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcvZzRz5s2MdQIy+7MD9Geaf7c7s2ujOyb3GzEulVCU=;
        b=PdZHCLy4tyPsCORSHKXlOgrWYgcynF+4LDS6ZNCqKu0ttBABMRXdqeTwbiY1MEyJVm
         QjVMPKUQt52vBIVjUFMviLRU3PBDYEGIrpiOZN4pHCzvUQT8lm9x2Ym3ZinaWFwOBOj/
         XHykgbUKvvUHzsWIUYUrdyLIzgsvi0Aq5o9KPgw/5jx8OPnow5duPlEY/QZpu3HJ11sS
         +qMKoI78cKkSCb3V97sboONIWCiEDIQZstGmy5eRCpegABiImdlNOCsprIKl/7HpHS4o
         hvyYI2Neg4Okobk7KQfFDZDWv1QeKDRoq+yG9ZjqDDZTqP5YIL7gpKHBDwGCJp7U5Jdb
         fkWg==
X-Gm-Message-State: AAQBX9dNzzELGPlsb7xvHlQs8r8IO6asjIU9PGnl3268h/JRc7hZXJMb
        e/h3IvUjQKnWC/mtzSj6EgECol2nCcC6rV8z
X-Google-Smtp-Source: AKy350Z+UYUbUZqZgLxGDvHKudAUOOcoEf7Qw2Oil9QesxAvPmEteYSgfKmF+LOl5+u592h766biYQ==
X-Received: by 2002:adf:e98b:0:b0:2c5:4ffb:b5d4 with SMTP id h11-20020adfe98b000000b002c54ffbb5d4mr3371013wrm.19.1679695903483;
        Fri, 24 Mar 2023 15:11:43 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id l12-20020adfe9cc000000b002cea8e3bd54sm19207794wrn.53.2023.03.24.15.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:11:43 -0700 (PDT)
Date:   Sat, 25 Mar 2023 03:11:41 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: rtl8192e: remove extra blank lines
Message-ID: <ZB4gHXhGnfPf3LMA@khadija-virtual-machine>
References: <cover.1679598576.git.kamrankhadijadj@gmail.com>
 <43d5864fc42e51089a0a0626278204bac8313eb0.1679598576.git.kamrankhadijadj@gmail.com>
 <ZB3ElynSQl98E6rf@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3ElynSQl98E6rf@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:41:11AM -0700, Alison Schofield wrote:
> On Fri, Mar 24, 2023 at 12:19:59AM +0500, Khadija Kamran wrote:
> > Remove extra blank lines as reported by checkpatch.pl
> > 
> > "CHECK: Please don't use multiple blank lines"
> 
> Commit log needs to say why you did it, why this patch need to be
> merged. Checkpatch itself doesn't satisfy the why requirement.
> 
> When we do these white space cleanups, the why is typically
> "to adhere to the Linux kernel coding-style."
> 
> If you are doing a particular checkpatch cleanup and are not
> sure what to write, check your predecessors.
> 
> $ git log --oneline | grep "multiple blank lines"
>

Hey Alison,

I have resent the patchset with the advised changes.
Thank you!

Regards,
Khadija

> That'll give you many instances. Reference a few, some poor ones
> sneak through.
> 
> Alison
> 
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_rx.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> > index c394c21beefb..c6114d99829b 100644
> > --- a/drivers/staging/rtl8192e/rtllib_rx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> > @@ -154,7 +154,6 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
> >  	return skb;
> >  }
> >  
> > -
> >  /* Called only as a tasklet (software IRQ) */
> >  static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
> >  					   struct rtllib_hdr_4addr *hdr)
> > @@ -318,7 +317,6 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
> >  	return res;
> >  }
> >  
> > -
> >  /* Called only as a tasklet (software IRQ), by rtllib_rx */
> >  static inline int
> >  rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
> > @@ -355,7 +353,6 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
> >  	return 0;
> >  }
> >  
> > -
> >  /* this function is stolen from ipw2200 driver*/
> >  #define IEEE_PACKET_RETRY_TIME (5*HZ)
> >  static int is_duplicate_packet(struct rtllib_device *ieee,
> > @@ -887,7 +884,6 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
> >  	return rxb->nr_subframes;
> >  }
> >  
> > -
> >  static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
> >  				   struct sk_buff *skb,
> >  				   struct rtllib_rx_stats *rx_stats)
> > @@ -1569,7 +1565,6 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
> >  	return 0;
> >  }
> >  
> > -
> >  /* Parse a QoS parameter element */
> >  static int rtllib_read_qos_param_element(
> >  			struct rtllib_qos_parameter_info *element_param,
> > @@ -1599,7 +1594,6 @@ static int rtllib_read_qos_info_element(
> >  	return rtllib_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
> >  }
> >  
> > -
> >  /* Write QoS parameters from the ac parameters. */
> >  static int rtllib_qos_convert_ac_to_parameters(struct rtllib_qos_parameter_info *param_elm,
> >  					       struct rtllib_qos_data *qos_data)
> > @@ -1843,7 +1837,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
> >  		}
> >  	}
> >  
> > -
> >  	if (*tmp_htinfo_len == 0) {
> >  		if (info_element->len >= 4 &&
> >  		    info_element->data[0] == 0x00 &&
> > @@ -1932,7 +1925,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
> >  	    info_element->data[2] == 0x96)
> >  		network->cisco_cap_exist = true;
> >  
> > -
> >  	if (info_element->len >= 3 &&
> >  	    info_element->data[0] == 0x00 &&
> >  	    info_element->data[1] == 0x0a &&
> > @@ -2142,13 +2134,11 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
> >  
> >  			network->dtim_data = RTLLIB_DTIM_VALID;
> >  
> > -
> >  			if (info_element->data[2] & 1)
> >  				network->dtim_data |= RTLLIB_DTIM_MBCAST;
> >  
> >  			offset = (info_element->data[2] >> 1)*2;
> >  
> > -
> >  			if (ieee->assoc_id < 8*offset ||
> >  			    ieee->assoc_id > 8*(offset + info_element->len - 3))
> >  				break;
> > @@ -2203,7 +2193,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
> >  						 &tmp_htcap_len);
> >  			break;
> >  
> > -
> >  		case MFIE_TYPE_HT_INFO:
> >  			netdev_dbg(ieee->dev, "MFIE_TYPE_HT_INFO: %d bytes\n",
> >  				   info_element->len);
> > @@ -2392,7 +2381,6 @@ static inline int is_same_network(struct rtllib_network *src,
> >  		(dst->capability & WLAN_CAPABILITY_ESS)));
> >  }
> >  
> > -
> >  static inline void update_network(struct rtllib_device *ieee,
> >  				  struct rtllib_network *dst,
> >  				  struct rtllib_network *src)
> > @@ -2580,7 +2568,6 @@ static inline void rtllib_process_probe_response(
> >  		goto free_network;
> >  	}
> >  
> > -
> >  	if (!rtllib_legal_channel(ieee, network->channel))
> >  		goto free_network;
> >  
> > -- 
> > 2.34.1
> > 
> > 
