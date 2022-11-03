Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFCD617822
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKCH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKCH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA62724
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:55:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5so560874wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYfWmdh3UC1nVq50HbeLN9JLwTkRyqhV7/oEk3b43+Y=;
        b=ivMVm5IzTNJdeVKzfWBTEhT/9EANHBbj8OThLwiUK9qKFZAFHqLpr2ELnRns2EqIl6
         4iQtVEzi0o093l7M7g3lrMnFzRfkePj2LQlzd81xwu5/QSQH9XqixseSHX6oN0wCn6FJ
         waBNuK9fJlFT5CsBzk55DAN3pCO874IS7EqUmwSBU+fO6FtcqS/7Bt3o0TAUCdELHR41
         oztkX6yb123JgH1JU12dVBt06U4ZBGmt9ITSoC4Od0Jj9JSjcF18QYjTtWGWcat/s0vr
         cOsaEgLhyc9xrbc2Dc5EBAI+vJTORch/daxdTHrv3wCZMJVbZBnShRGbIIvCPqhLo7wH
         PIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYfWmdh3UC1nVq50HbeLN9JLwTkRyqhV7/oEk3b43+Y=;
        b=YuW9SGG+80hIm0m2OPOSdJzn1ymEk3/P6r0hpgyiru8EJ34V8Z2c7XDf5/OMyBqcWF
         WphAU14pn/d42nhOuzBk0rACLH4jQDrI+EC30NFjYc84grOgkfeKdVcVmP4NrI4kf2+C
         GP+KYmMHjKXxgnhpY2dFFQ5MJWCLWbrKC1P9Kgab/T7d7NlA7/l6OGXZC+nFYI1HShUw
         J5Abwr0KqMai9LFv/qHKiDz48YSGlF3haA/Su6FBEN7W49kLlG7/qJZL1ekP2MW+BIk9
         c8ZbKQ3Jq6IJk+qMc45RZYlV7OszYceANgUfq7KrzHe5wUdczglppgb4jFCTWB8Sizr8
         K+MA==
X-Gm-Message-State: ACrzQf0J/JU5vRrbybps5Ba5bvXrbXzr5cXYun/DNgOpZVm8kTlpCizy
        gRJxXsQDVd8AdvJ5hQMLT5azeKgAJ3obVg==
X-Google-Smtp-Source: AMsMyM5W394NjFKWc+NM2AZ0Epeklh7wOQPiztbeJZsH8JTMmMxrPMFydWB/BT23jtEMPvuyEcrwzQ==
X-Received: by 2002:a05:600c:29a:b0:3cf:8e62:66f1 with SMTP id 26-20020a05600c029a00b003cf8e6266f1mr333329wmk.39.1667462131870;
        Thu, 03 Nov 2022 00:55:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b003cf75f56105sm437848wmq.41.2022.11.03.00.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:55:31 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:55:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: emxx_udc question on i_write_length datatype
Message-ID: <Y2Nz7wB5ovzgrs6N@kadam>
References: <Y2NtTXwMef0kp01s@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2NtTXwMef0kp01s@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:57:09PM +0530, Deepak R Varma wrote:
> Hello,
> While reviewing this [1] coccicheck warning, I observed something that concerned
> me. The variable i_write_length is declared to be of u32 type. Later it is
> assigned a value DMA_MAX_COUNT * mpkt; which is 256 * u32;
> 
> I am unable to estimate if mpkt (or max packet size) can attain value greater
> than 16777215 in which case the result will overflow the 32 bits of
> i_write_length. Is it safe to make i_write_length to be a u64?
> 
> [1] drivers/staging/emxx_udc/emxx_udc.c:1007:28-29: WARNING opportunity for min()
> 

drivers/staging/emxx_udc/emxx_udc.c
   983  static int _nbu2ss_in_dma(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
   984                            struct nbu2ss_req *req, u32 num, u32 length)
   985  {
   986          dma_addr_t      p_buffer;
   987          u32             mpkt;           /* MaxPacketSize */
   988          u32             lmpkt;          /* Last Packet Data Size */
   989          u32             dmacnt;         /* IN Data Size */
   990          u32             i_write_length;
   991          u32             data;
   992          int             result = -EINVAL;
   993          struct fc_regs __iomem *preg = udc->p_regs;
   994  
   995          if (req->dma_flag)
   996                  return 1;               /* DMA is forwarded */
   997  
   998  #ifdef USE_DMA
   999          if (req->req.actual == 0)
  1000                  _nbu2ss_dma_map_single(udc, ep, req, USB_DIR_IN);
  1001  #endif
  1002          req->dma_flag = true;
  1003  
  1004          /* MAX Packet Size */
  1005          mpkt = _nbu2ss_readl(&preg->EP_REGS[num].EP_PCKT_ADRS) & EPN_MPKT;
                                                                         ^^^^^^^^
mpkt is 0-0x7ff so 256 * 0x7ff will not be greater than UINT_MAX.

  1006  
  1007          if ((DMA_MAX_COUNT * mpkt) < length)
  1008                  i_write_length = DMA_MAX_COUNT * mpkt;
  1009          else
  1010                  i_write_length = length;
  1011  
  1012          /*------------------------------------------------------------*/
  1013          /* Number of transmission packets */
  1014          if (mpkt < i_write_length) {

regards,
dan carpenter

