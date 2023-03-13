Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F86B7BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCMP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:28:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA434C13;
        Mon, 13 Mar 2023 08:28:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b10so13064577ljr.0;
        Mon, 13 Mar 2023 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Efv1Q+RhWD0A+py4ZpjEC//VTgOMnS23pAzZYge/8=;
        b=Zb7CYnLDxSGfdWSErnn5zIokQ5RWCC6jvTCf2NKa/i3fqVS/JyyH7xb9TyB4gQiV3J
         waQSg6467g9wEmjPb1ZeRKOOXEdHuj68FMfOIdB/iPuxAuXVNtBtlQZMSuUNVEodqmRi
         Jl0c/U6u5/IPaw+klPNt6hA+3b2UPePeF1ObD0Tj07YmBZODsmFqBEi82LU9Tf53O31k
         s66ORTg5UJHxzYBsPRDDIS1kKOKbZhySBqwtQBfnyCztLhqqw65FEqK1zlr1koD7iCwi
         gdLZt8rqZU9wst9I5nanDUijVMNmALWv7xHW9W/kHg/IApyVm1Pa+neBubMsxgPFXPHx
         vQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/Efv1Q+RhWD0A+py4ZpjEC//VTgOMnS23pAzZYge/8=;
        b=UplWiqIppT8jYP03M3W2nOlQ0Wz0KCibJRQu4ZdTM7M/wPA7Lu4pskkDvoGzZ/s3Km
         ZzzswlyzxoioIRN7pCuhzBDMUXLISNAl6150iMNN47K3jfVH+LfnafbxLesTC5AE7fAh
         1GU/iRPQC5m6ljjqAd7M9GZafYVr/QMCHOQgSZTWB/BbN96GCy2ktC57L+gDTMkef5+W
         yOva6E9FiaD3WGEBtfB9peVGGLcRK2T3HdsriaIH4n6Q3KVtzhmBFjZuMlIqzys5bViH
         2vmSxtAsFsai39PObGsJ7esBzthMcT20RwoFyydEK4oNVlQKCG7rITj0BhE2gy3QZuxW
         CZCg==
X-Gm-Message-State: AO0yUKVHTgUsO/p8kuWkqSWHm+XKngsqgVojVvrErgqaHQ/n0F6Zgz6A
        N1lyQRru9IeBnof9rEQ6WfsJ6iIEAr8=
X-Google-Smtp-Source: AK7set+UikKdNtAsVnEUzBfRceSmosi0YIVnO0yQn3ygsYHmI4F4JWW7qPA2WN4r37vxLp4CAISDPg==
X-Received: by 2002:a2e:a586:0:b0:298:39fa:b04d with SMTP id m6-20020a2ea586000000b0029839fab04dmr12593338ljp.33.1678721316787;
        Mon, 13 Mar 2023 08:28:36 -0700 (PDT)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e9d54000000b002958bf18efcsm25141ljj.104.2023.03.13.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:28:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 13 Mar 2023 16:28:34 +0100
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZA9BIgEN2MGwAgd3@pc636>
References: <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
 <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
 <ZA7yK6iznHqiBu5i@pc636>
 <ZA8WxjUL0eUPtVy8@pc636>
 <IA1PR11MB61714FA7A6FA92307B7FEF7C89B99@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61714FA7A6FA92307B7FEF7C89B99@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:48:18PM +0000, Zhuo, Qiuxu wrote:
> > From: Uladzislau Rezki <urezki@gmail.com>
> > [...]
> > XQ-DQ54:/ # echo 1 > /sys/kernel/rc
> > rcu_expedited       rcu_improve_normal  rcu_normal
> > XQ-DQ54:/ # echo 1 > /sys/kernel/rcu_improve_normal 
> 
> Hi Rezki,
> 
> I applied your prototype patch, but I did NOT find the sys-node:
>  "/sys/kernel/rcu_improve_normal" on my system.
> 
> What is this node used for? What am I missing? Thanks!
> 
> [ There were only "rcu_expedited" & " rcu_normal" sys nodes
> on my system. ]
> 
The prototype i posted does not have such helper, i added it just
for my local tests.

--
Uladzislau Rezki
