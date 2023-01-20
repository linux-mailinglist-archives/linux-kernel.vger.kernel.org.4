Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1044674903
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATBrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjATBrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:47:20 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1628A9D2A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:47:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e8so3163846qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyQbDs7HBixw8EukE3w9IBEC2xEjoX+NR7SoW/oXAGU=;
        b=K+b24l2HVndz0EyvMYAjay5yVALhz1Uft+YM2lg2Edz2+qN36ESe4PWhA68/w93wZp
         BNgDLzk41hB373N7WdDwPcjKH8t5OOgFUFYFiAvDV2h66FgZ+jRm62UNCGu0eBtI145L
         /6551RJlUmyIIe6OE0wfYeRC72ZMqOuEwD2Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyQbDs7HBixw8EukE3w9IBEC2xEjoX+NR7SoW/oXAGU=;
        b=YKmq2NkGl/DKK9uDm4gSjsdAxt2KTweuMCUrm41VAKS8q4+9B/CpeK2eH0ZHC5z4my
         6FjgzSpv04MNVUkXht4MFkAUuprQ1dytnTEJJjL2HNE6cuAEndOmZXX0WjKTz/xBiL3s
         6CsMmWK/r4TajyPiqsJH7ytcH7q35ii4u4T9nsZHAOREVCNDXpMA25WRXs+kZlbdpIBM
         NsshQGoM3JAX0LHtxFecZcDxxKSQlXyRD7divAJ+SzGF/Stv1UDiDCxqe36Q5M4PD+4s
         zZ/I6s3Ny8GoGXeSrJjm+vjrHau9gUYphxkLyBJF/NTM7PC9C0pIejBNm2kiIyAwnsnp
         SgnQ==
X-Gm-Message-State: AFqh2krOsqQzOSD1Yza6PkY0pAZmPiWOkFoqcbyd8TaGexs2SyaFJNrF
        uGW9WIV8eS9gHqlSo+FOrsKvjA==
X-Google-Smtp-Source: AMrXdXvi1nG1kiSvrD1IzqiCTywY2pJQ5RTLVG7BHlyu2RujlizVTf64VYsUFdd4syrV8re6MbvGGw==
X-Received: by 2002:ac8:534b:0:b0:3a9:6b48:a13c with SMTP id d11-20020ac8534b000000b003a96b48a13cmr17687316qto.51.1674179238125;
        Thu, 19 Jan 2023 17:47:18 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id hg20-20020a05622a611400b003a81eef14efsm19714182qtb.45.2023.01.19.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:47:17 -0800 (PST)
Date:   Fri, 20 Jan 2023 01:47:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] rcu: Further comment and explain the state space of GP
 sequences
Message-ID: <Y8nypBG5k+D3YXHO@google.com>
References: <20230119141134.686626-1-frederic@kernel.org>
 <Y8lQjKKDd0G2zt3F@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lQjKKDd0G2zt3F@lothringen>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:15:40PM +0100, Frederic Weisbecker wrote:
> On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> > The state space of the GP sequence number isn't documented and the
> > definitions of its special values are scattered. Try to gather some
> > common knowledge near the GP seq headers.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 115616ac3bfa..fb95de039596 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -14,6 +14,39 @@
> >  
> >  /*
> >   * Grace-period counter management.
> > + *
> > + * The two lowest significant bits gather the control flags.
> > + * The higher bits form the RCU sequence counter.
> > + *
> > + * About the control flags, a common value of 0 means that no GP is in progress.
> > + * A value of 1 means that a grace period has started and is in progress. When
> > + * the grace period completes, the control flags are reset to 0 and the sequence
> > + * counter is incremented.
> > + *
> > + * However some specific RCU usages make use of custom values.
> > + *
> > + * SRCU special control values:
> > + *
> > + * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
> > + * 							is initialized.
> > + *
> > + * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
> > + *
> > + * 	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
> > + *								we are scanning the inactive readers
> > + *								index.
> > + *
> > + *		SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
> > + *								Indicates we are flipping the readers
> > + *								index and then scanning the newly inactive
> > + *								readers index.
> > + *
> > + * RCU polled GP special control value:
> > + *
> > + *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
> > + *								has completed. It's an absolute value
> > + *								covering both the state and the counter of
> > + *								the GP sequence.
> >   */
> >  
> >  #define RCU_SEQ_CTR_SHIFT	2
> > -- 
> > 2.34.1
> > 
> 
> Ok perhaps this one got the tabs right:
> 
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Thu, 19 Jan 2023 14:29:34 +0100
> Subject: [PATCH v2] rcu: Further comment and explain the state space of GP
>  sequences
> 
> The state space of the GP sequence number isn't documented and the
> definitions of its special values are scattered. Try to gather some
> common knowledge near the GP seq headers.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 115616ac3bfa..fb95de039596 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -14,6 +14,39 @@
>  
>  /*
>   * Grace-period counter management.
> + *
> + * The two lowest significant bits gather the control flags.
> + * The higher bits form the RCU sequence counter.
> + *
> + * About the control flags, a common value of 0 means that no GP is in progress.
> + * A value of 1 means that a grace period has started and is in progress. When
> + * the grace period completes, the control flags are reset to 0 and the sequence
> + * counter is incremented.
> + *
> + * However some specific RCU usages make use of custom values.
> + *
> + * SRCU special control values:
> + *
> + * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
> + * 					is initialized.
> + *
> + * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
> + *
> + *	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
> + *					we are scanning the inactive readers
> + *					index.
> + *
> + *	SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
> + *					Indicates we are flipping the readers
> + *					index and then scanning the newly inactive
> + *					readers index.
> + *
> + * RCU polled GP special control value:
> + *
> + *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
> + *					has completed. It's an absolute value
> + *					covering both the state and the counter of
> + *					the GP sequence.
>   */

Other than the minor comments in the other thread:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  
>  #define RCU_SEQ_CTR_SHIFT	2
> -- 
> 2.34.1
> 
