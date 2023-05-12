Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB036FFE15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbjELAlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:41:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C859D2;
        Thu, 11 May 2023 17:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5777F652E5;
        Fri, 12 May 2023 00:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0866C4339B;
        Fri, 12 May 2023 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683852068;
        bh=buIg82FsdUAF2Q1U/hR23a0od1zuZD5R5znK2wDNEQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FR9CtCjJXhscTX6v+8eud1o8h8AsAJ6CvD1UDO3Ny+kWOY9I3O9HZWktWAa4grjkn
         Iu2OcNzq7LNVuMd1AEPkfLMajCndiwQ0+Q8bE8R5idpeMifggxQOIvWzGpsdeaHzGj
         uw0q9ORsxXvVUbTAZZ6Zkk7ahY/q3m1DG8KrGl+7L1TgsrC5o2UvMok/vvtuOes5ws
         ijPJslKVstS6L8cNoZhC16eMm9dtwSEAZeqPBdQugC5x4SfsrLQ6ndDNRYe+NLfagJ
         KRWdc4iu8NbhhqNFDyNXwnglJWhTXm65486914Yp/k8CS14VXp6ZGdMxz5nxJO8z4U
         K5CWoACLAPKTw==
Date:   Thu, 11 May 2023 17:41:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Watchdog Devices <linux-watchdog@vger.kernel.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Airlie <airlied@redhat.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Sam Creasey <sammy@sammy.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.com>,
        Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Deepak R Varma <drv@mailo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Dan Carpenter <error27@gmail.com>, Archana <craechal@gmail.com>
Subject: Re: [PATCH 00/10] Treewide GPL SPDX conversion (love letter to
 Didi)
Message-ID: <20230511174105.63b7a6ae@kernel.org>
In-Reply-To: <20230511133406.78155-1-bagasdotme@gmail.com>
References: <20230511133406.78155-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 20:33:56 +0700 Bagas Sanjaya wrote:
> I trigger this patch series because of Didi's GPL full name fixes
> attempt [1], for which all of them had been NAKed. In many cases, the
> appropriate correction is to use SPDX license identifier instead.
> 
> Often, when replacing license notice boilerplates with their equivalent
> SPDX identifier, the notice doesn't mention explicit GPL version. Greg
> [2] replied this question by falling back to GPL 1.0 (more precisely
> GPL 1.0+ in order to be compatible with GPL 2.0 used by Linux kernel),
> although there are exceptions (mostly resolved by inferring from
> older patches covering similar situation).

Should you be CCing linux-spdx@ on this?
