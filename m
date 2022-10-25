Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2860CA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiJYKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiJYKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:48:39 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78116EA20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:48:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 580732012C;
        Tue, 25 Oct 2022 12:48:36 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JvSzNkeAq4sF; Tue, 25 Oct 2022 12:48:36 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 8438120119;
        Tue, 25 Oct 2022 12:48:34 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1onHU1-00946j-2N;
        Tue, 25 Oct 2022 12:48:33 +0200
Date:   Tue, 25 Oct 2022 12:48:33 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Eric Curtin <ecurtin@redhat.com>
Cc:     gregkh@linuxfoundation.org, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        "open list:SPEAKUP CONSOLE SPEECH DRIVER" <speakup@linux-speakup.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] speakup: include types.h so u_char is a known type
Message-ID: <20221025104833.io3spnxw7724vlhb@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Eric Curtin <ecurtin@redhat.com>, gregkh@linuxfoundation.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        "open list:SPEAKUP CONSOLE SPEECH DRIVER" <speakup@linux-speakup.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221025101828.1626490-1-ecurtin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025101828.1626490-1-ecurtin@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Eric Curtin, le mar. 25 oct. 2022 11:18:24 +0100, a ecrit:
> Fixes build of utils.h header file, occurred when building kernel on
> postmarketOS on Lenovo Duet Chromebook.
> 
>   drivers/accessibility/speakup/utils.h:57:9: error: unknown type name 'u_char'; did you mean 'char'?
>      57 |         u_char *pn = (u_char *)name;
>         |         ^~~~~~
>         |         char
> 

There is already a patch pending commit that just replaces it with
unsigned char.

(see
Subject: [PATCH] speakup: replace utils' u_char with unsigned char
)

Samuel
