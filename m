Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE17B6E318C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDONRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDONRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 09:17:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E324C26
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 06:16:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c9so13610118ejz.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681564614; x=1684156614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzXYreqeYmp6WSmJydUbNuUOo6bx8j3ScmTlAns1itY=;
        b=o/5jI2eEJPlGzyiPn2+Hq179ixbP06pFO7i0tRo64AQKQv3BmsoCMh3ejMG6ni1eis
         ZaCjqJOMxXbWgJwVMY/MTaabI4ag9AvgU1Wxf50EXAWKmT/UtbY+AGlNXOyEkSXGyJlB
         7Bk59GIb9zvkEQ7HwdPbtEN1XLfZgeA1I4O1awUClFHoFrDvJmIFCMRy22D4rHrVjVFb
         uDzF9OXn5hQJutiMYDVgsm+KbnGDadBKoTZD5vSwR4/ukuEk+7js1z+t6xIr+Y3l19+A
         K3WSl2L8eJ3zPyIlq3snlEZFPL60Yn83ylLQZzXpc+xAo3oORBeoCAl3jGcjbOucK6pl
         6EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681564614; x=1684156614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzXYreqeYmp6WSmJydUbNuUOo6bx8j3ScmTlAns1itY=;
        b=lnmNJ7Ds2GTSdeCGAmXCPI7cZyJOIlJmqAuPx4WmXQlZmMQCsRR71wu3pijBNnTfD9
         x0VMNZMymORX+VImT5QMMyPNUbEeRiov+rNdStINsKxJe9jlumEbYyrEqcwiLFLtkCtN
         5mERBWgnMZcNLk1a12aywgEfwG2JUzT5A0gleg6igQkvPOCM23BdjK86mJFiMez0G5u+
         JeCHdEK6AF3frgteRZpFr9DHzLOS2j7icp2dUOR9HRGIu1LpVHeYij/AMIo2fyNfOJyT
         N5GRarOkJKHQfry7AgN6scpcbrilz3KD/TRCC96iO235bKcrJ+OQ8KVCtmlllSQtPYmN
         13Gw==
X-Gm-Message-State: AAQBX9cB3lzCJorOQzVcQdiVo+BVPb+gGn7ef6kTk1AR0QwJYL9wZ98q
        8dsB7j89UpJpnIht5VlK548=
X-Google-Smtp-Source: AKy350bH574+eHb/fXQCB7LwDuC7J12RbSehsjCQVJbOR5bQpYiisRqa3tCAONuRfTjOONLAvRgJAQ==
X-Received: by 2002:a17:907:7809:b0:949:c05d:73b6 with SMTP id la9-20020a170907780900b00949c05d73b6mr1872274ejc.17.1681564613546;
        Sat, 15 Apr 2023 06:16:53 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906779800b0094edbe5c7ddsm2432788ejm.38.2023.04.15.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 06:16:53 -0700 (PDT)
Date:   Sat, 15 Apr 2023 13:39:38 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: replace rate macros
Message-ID: <ZDqM+seGtevADusa@kernelhacking.kernelhacking.example.com>
References: <ZDqKb1iuoSQTYXJM@kernelhacking.kernelhacking.example.com>
 <714c5d3f-438a-4633-a46e-127f876ffec4@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714c5d3f-438a-4633-a46e-127f876ffec4@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:43:20PM +0300, Dan Carpenter wrote:
> Writing every sentence in imperative tense makes people sound like space
> aliens in human skin...  You can if you want to but it's not a
> requirement in staging.  There are two maintainers who have that
> requirement and the Outreachy people.

> > -	struct p80211item_uint32 basicrate1;
>                                  ^^^^^^^^^^
> This starts at 1 instead of 0.

> > +	for (int i = 0; i < 8; i++) {
>                  ^^^^^
> Now it starts at zero.
> 
> > +		if (count >= i &&
> > +		    DOT11_RATE5_ISBASIC_GET(item->supprates[i - 1])) {
>                                                             ^^^^^
> This is an array underflow.
> 
> regards,
> dan carpenter

Thank you for the heads up on the (lack of) necessity for alienspeak and
the code problem.
Starting at 0 should not have made a difference but I totally missed
that underflow... embarassing.
I'll make sure to fix that and resubmit the revised patch.

Thanks,
Luke
