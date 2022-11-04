Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FDC61968D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKDMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKDMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:50:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49865EE31;
        Fri,  4 Nov 2022 05:50:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x15so2915617qtv.9;
        Fri, 04 Nov 2022 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCg5U14h823fd/E6HfvfZMyPQS0BVVOBKdKh70+tEco=;
        b=MURPBtT6SMZEFPvlZ8dHt6QTCIs5u7eDlYRQ3df41UwWgEh9kUXPkmMZbegcaIqQc+
         VtdIXBcpivNIG+MwsAxsi1gWcu27Lg+p+1EfAm4iqF9bGgY6GUKPc7Coa1GZd+aSuQpZ
         cXBptuU89TH8TrYCxBaIPooysc3ftyCMwDudNaGqymcrcll4CalAqI4IwaTmTPFv8WxF
         BpT3inRmHsyD8O1+hpHeg48LJqJC7MyrjE1mbeK/ug/m6tUboARBrx5FWHxMDRb9LZCJ
         TXcoY68JAzPx5dIxdG9DXMVWbZiZkZnnQqyXhzKK3bntebhaK8f3coZjgVRxRFBOyDke
         bVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCg5U14h823fd/E6HfvfZMyPQS0BVVOBKdKh70+tEco=;
        b=vL3ahOlA0IVmC/ne0uLgAB7P6YQQ3OcreSG9sZcGjgLU4iU+NllphU2RuMSt4gRR6V
         NyoBV/fbEP+sCygcj5TqWJ/7JYx9uwqs0e5syqHOgnhbDRDDbfEHk6QUQQIMdweJXREs
         /6I2Io44DtDzxrDWR2gfVlYQncir87yXRzaoxOON47TYMv7tIvZxYNBLI93joQ5tA41C
         VxJFwsTRevlUdEkXKBuam7adgmvQn4ABHdmrDGjgu3Y9y022ClQtFkyfEAFhJWSiaiJD
         xgd3lArW82ZCf+DQXQ9TSIIRnB+EQ3o//3onFuUJBGoobW3XZbaBM+hqJ6HNPLG6REhy
         RjGg==
X-Gm-Message-State: ACrzQf0YRLzjfDqB8sucRIr8pnY0aHN7jx3Kn8E9gvtjaOZcmDKeR27J
        1I900gnk495+++3Y0g9IxFtjsxJxtkNcF+mXRvOhHDKk1BU=
X-Google-Smtp-Source: AMsMyM7/vR6BHUB9wDEQrhkpI1dQLqYW8s55rI35FAXgGTlmy57auC3tsOsnHMCOAwGP85036yjCWc8xjBfR3E7Hqq8=
X-Received: by 2002:ac8:7152:0:b0:3a5:2fa2:cd1a with SMTP id
 h18-20020ac87152000000b003a52fa2cd1amr18686625qtp.195.1667566243392; Fri, 04
 Nov 2022 05:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
 <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com> <PH0PR11MB50964BC2301907D51B3DCF119B3B9@PH0PR11MB5096.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50964BC2301907D51B3DCF119B3B9@PH0PR11MB5096.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Nov 2022 14:50:07 +0200
Message-ID: <CAHp75VfGZf_aM4+ta10kxaktwvkk9XiV=8ttAg7hcFV-rBtY1g@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 12:23 PM <Tharunkumar.Pasumarthi@microchip.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, October 3, 2022 2:57 PM

> > If you have similarities with 8250_pci, probably you need to split it to
> > 8250_pcilib.c and share. (See how 8250_dw /8250_lpss are done in that
> > sense.)
>
> All the functions used in 8250_pci1xxxx.c  that have similarity with 8250_pci use registers
> that are specific to our IP.  The only function that can be moved to common library is the
> setup_port. But, for that the first argument of setup_port must be changed to
> 'struct pci_dev *dev' (priv->dev).  Do you suggest doing this?

So, you can create a common serial8250_setup_port(struct pci_dev *dev,
...) and call it from the static setup_port() inside 8250_pci.c. This
way you won't introduce too many churn.

-- 
With Best Regards,
Andy Shevchenko
