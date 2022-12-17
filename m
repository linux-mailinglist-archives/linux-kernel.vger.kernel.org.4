Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B864F921
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLQNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 08:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 08:44:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783114030
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:44:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gh17so12179773ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebhr88sjUTXtMXQu9OmfKOHHux3PqdG2ANG4GsmQwGY=;
        b=pNFjP66HWmyIeHkQHy7jk8OT3O0WtaM1i7BsfpXXvfEcQayANx1xGNKlyQbRhufwB4
         SLeiZdrtQjQdE5siXJCEGGto6xiOOw/lWdyWBjlvusuLukA8+6MJbFJROHk/bT9eEEC4
         QnWdphiONO6eda23RoKEWZvXLFq+Nxj8wzfHgxw2yhLDMQnatNt42vTl6uOOVzMViDIS
         DX1IsD1EMCu9bUOUD2uI1eMvwylM9LQwOWczNb4QSRUWfswyuNb6zPVX6BhHlGHKvPEW
         ZNm8wv4VEEzFGM0xUK04xblTnVuQSQJjcnnbCeqN33LMRBs6Q2IrQ3hX26FXzA4MQP90
         tZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebhr88sjUTXtMXQu9OmfKOHHux3PqdG2ANG4GsmQwGY=;
        b=jqKAfUUbr9GarhJRo7atKm38anh3zR8ozZg3GAaSvLah+kNwsJfxDviDpbZdbyCpW+
         P2f7uD7LSsVL4ffPar8O4OfD06GtUNTpQPN4zXe/9OmbeH6sNESuXCMd2lJ6OtHSXLe1
         liEDrbDZEPD8gHOAe4TOBxlTmxqayVQkD0KyRn6mCujruAIDlJyRGq3Wbcr8QMWPt8fi
         OvfzQmtfpbBrkFa0PMEEymCquvVGeBEVFbs8yOFXV4VuIHm/sGDoibWdNky69kfm+16e
         IdNtdMKevU54MhOOkCLcolE9N0wuUCBgxSu11GgzPuiw2Mn9LcwECeHBCTwLhCrymsfV
         00ew==
X-Gm-Message-State: ANoB5pnPo9bN2nRcan8g2nAeVMpoGbdchp5eK9ry13lUWr53WfnUzofq
        PwsIx+HO6hdJs+hfWDP3tLZcP75dcjoTYfEdptrUPQBEd6A=
X-Google-Smtp-Source: AA0mqf5TeS0xucgtfMa7R7xHJOIGoRLXB3PldFuvGMbxjcJk4+pIWY7yCe16FSX4zxS9HR5LshQnR+5XoWVWQlBK1b0=
X-Received: by 2002:a17:906:1546:b0:741:5c0e:1058 with SMTP id
 c6-20020a170906154600b007415c0e1058mr80875935ejd.472.1671284671172; Sat, 17
 Dec 2022 05:44:31 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com> <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com> <Y53BputYK+3djDME@kroah.com>
In-Reply-To: <Y53BputYK+3djDME@kroah.com>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Sat, 17 Dec 2022 19:14:14 +0530
Message-ID: <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

:-) Got it.
Taking your point into account, I'll rephrase: as the _convention_ is
to mark the last release in the year as LTS, is there any visibility
on when, or if, it comes about?

Thanks,
Kaiwan

On Sat, Dec 17, 2022 at 6:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 17, 2022 at 06:32:48PM +0530, Kaiwan N Billimoria wrote:
> > Hi,
> > Any update on 6.1 being set as the next LTS release?
>
> You tell me please.  How has your testing gone for 6.1 so far?  Does it
> work properly for you?  Are you and/or your company willing to test out
> the -rc releases and provide feedback if it works or not for your
> systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
> anything missing in it that you feel needs to be addressed with a newer
> kernel instead?
>
> thanks,
>
> greg k-h
