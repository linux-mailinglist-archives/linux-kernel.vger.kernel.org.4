Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2364C704A87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjEPK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:28:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8079D;
        Tue, 16 May 2023 03:28:34 -0700 (PDT)
Received: from localhost ([31.220.116.19]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3Xvv-1q6wcL3nDH-010eR4; Tue, 16 May 2023 12:28:19 +0200
Date:   Tue, 16 May 2023 12:28:18 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <ZGNawohZTDhPazil@arbad>
References: <ZFUCf059+PSR+3Wb@arbad>
 <ZFUC/3zBFQRBsYUk@arbad>
 <20230506170420.71bead77@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506170420.71bead77@jic23-huawei>
X-Provags-ID: V03:K1:Bd0SdWuyGMZ0Xl9NCXajCiIF4veXtIMrhG4X94KnSmKcBVJV++x
 vXSEiId2lKnB+89CFB6ZRoJyVJnFcASUCGmnpxeWfLwdy0GksCYE1A4yNS4+GDDcz5+/wax
 okXAZMIv2RRTY6wxNouDUlMBM26u7vo3fyH5WjqsPte82BbISslolYleUr5zZqjHl3Hp1p0
 9St9RP5IMRhOlY/y+gvPg==
UI-OutboundReport: notjunk:1;M01:P0:xQDyem14oOc=;XddJOI4rFIaxukEi9U5MCloXRWW
 UoRH3UWxE6uqmX/zSOdGE/1hUL+AL5yqRiQGrfq6M+Rwo/yRWeD8vofIN8xF6y5A69in8PAFg
 LYjIO4nXGsztQFhElNDUGvtSrBNVNVhCGUXd8S/MWrAZrVUqY33xbmJTVaTvfd9NJ4t9PcfUe
 WCrVjzL2ERdkj0Sn0gumKjwFa2V0sxwQMg4n5LtCi5ppg4Sd0AvS9SPR0hRiELuBUYn2gytHz
 GFBXJuZdSCbthbxmnF7bpAZbCzzTYMeIDpiu+/KqH2LQEdxqShzJhDq6N1YrPStPGOL7DURDv
 epTwlgocm2HCixwx5jtBg+LxZjbD7JYnAkfLYGgFn3gRowa0j3ifQgGVXps4ZnMywTuQUlpP4
 v2yoYURCCf2ERYZss2rGs2eTzq3tIpqg1lBYklO47m72MiT3Td76nZ3Ebbi+3+DYe034bMhFN
 H52/al1mnZBEg9JHRmi+qY45VM4JV5RNaKgNd+L80Tk1d9IrnDJtSO3XjLj759ZZNpHM1qIr+
 3QDFhOa+MY6wQXEgsfgNggbmiaB6qb4mnU5KywaAwnVw2CjjvT0JhF/7oWe8s9rBTc2L8l94N
 wHev/g0TD7rE8ny1+BMFirmp4+ctNcWbJZYruwEVN+LryDNd+vdEr++VKFw6Mhavk38qAJPWt
 /nG+s4IPFWI+w1EuCQh+sqzdxp1yYpOG88GrLhG33g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thanks for your review. I have one comment.

Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 06. Mai 17:04:
> > +	int                     scale;          /* int part of scale */
> > +	int                     scale2;         /* nano part of scale */
> > +	int                     offset;         /* int part of offset */
> > +	int                     offset2;        /* nano part of offset */
> > +	struct gpio_desc	*gpiod_reset;	/* reset */
> > +	int			irq;		/* end of conversion irq */
> 
> Only needed in probe, no need for a copy in here.

It's also used in mpr_read_pressure() to distinguish the two possible operation
modes:
- waiting for an interrupt
- reading in a loop until status indicates data ready

Andreas
