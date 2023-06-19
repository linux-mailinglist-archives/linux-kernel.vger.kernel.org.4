Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DCD734D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFSIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFSITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:19:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B6FA;
        Mon, 19 Jun 2023 01:19:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-988e6fc41ccso20201766b.3;
        Mon, 19 Jun 2023 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687162791; x=1689754791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFHkTes8DrKw9cwR8pyZFdUyDvr03PKoP5YKGbpmVFI=;
        b=FIMM1NNke8QgY6YTZDycoAXTOmacd/2jr/2eNabYgpy+NtqQdsIJHLESxKKION5YXR
         fkrHoKlXZuLl6VI3414HGaWYxtYEakGNgGelXznIdkCMN8JOBvwgx0pWA9y3iFNW7DNh
         gnzDCGOdsdfGlNGZHBVyBFGqqu4BbRMamzp/1t0tnh82BxD8DnrHtGnTnOtN5MDR2zHx
         aWZmsKZeUzSQphSu1tHYIsHZcsA6oNWo3V5hwpQukI6azw7lW7Zmj2DaSPj+S+UnIK1z
         OCWqtn/7BY1/+i9on+uOwt7R2ccDAEkTnmzZSifmy40n6CztG2Ss7CzMAvV/qJeJgd9K
         zO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162791; x=1689754791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFHkTes8DrKw9cwR8pyZFdUyDvr03PKoP5YKGbpmVFI=;
        b=FR617PURaeTG0pywsWwIUC1cctZJWzvl2D4nTOXF+VcU51lQPcaNjVPEKfeJE8uUoQ
         NnL67kaE+V1losbK0SUdvgAVa7GTSKlzO2HuDu8E8K9tJY9dgaigcCa3lSm6FwIL5KdG
         RJmrWTyfgeaM9X+uP+Pn+XNJ7zDIrjqbA35vQ+uzFlfM2mrvzk35TSYUXPDVOFL2Sstq
         dSwHxOzAe0GEdaOJWptLHk1zyT77DgQ2VfOYe5OG+eUFkICGVnGloce09T8384PglbCA
         o0BBoqTJG8KIyoSRaE63FgJsGhtfygSTUJWFNt51XDOFs4hd0HAqrTUpd+p0tBXA6hhg
         V9yA==
X-Gm-Message-State: AC+VfDxdHwBGoZZAR33oT9/FIa+axoD3MRXdtDQTWLYK0nPiSMQcNLdP
        KCyBW4LhtvM69cOs9i3v5fc=
X-Google-Smtp-Source: ACHHUZ63Dj5hadfhxWMjs8TUCRxjMwPLmhmAnA27KrmdZvk7i5867WtemrAERVQ44S3AdvyT1/NGBQ==
X-Received: by 2002:a17:907:3e97:b0:973:344:6a39 with SMTP id hs23-20020a1709073e9700b0097303446a39mr7486763ejc.76.1687162791299;
        Mon, 19 Jun 2023 01:19:51 -0700 (PDT)
Received: from shift.daheim (p200300d5ff26fa00aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff26:fa00:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id w9-20020a170906480900b00986211f35bdsm4479490ejq.80.2023.06.19.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:19:50 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qBA74-0003da-1F;
        Mon, 19 Jun 2023 10:19:50 +0200
Message-ID: <f4b0f337-c530-8c4f-dc22-cfaf834dd5f0@gmail.com>
Date:   Mon, 19 Jun 2023 10:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
Content-Language: de-DE
To:     Anne Macedo <retpolanne@posteo.net>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230618224656.2476-2-retpolanne@posteo.net>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230618224656.2476-2-retpolanne@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 00:46, Anne Macedo wrote:
> Cards based on Renesas uPD720202 have their firmware downloaded during
> boot by xhci-pci. At this step, the status of the firmware is read and
> it takes a while for this read to happen (up to a few seconds). The
> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
> status byte from PCI a few times. If it can't read the status byte in
> RENESAS_RETRY tries, it times out.
> 
> However, since this may vary from card to card, these retry and delay
> values need to be tweaked. In order to avoid having to patch the code to
> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.
> 
> If applied, this patch helps to fix errors such as:
> 
> ROM Download Step 34 failed at position 136 bytes
> Firmware Download Step 2 failed at position 8 bytes with (-110)
> 
> while loading xhci-pci when using these cards.
> 
> This error in particular has been noticed by this e-mail [1].
> 
> [1] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/

Can you tell me on what hardware (is it something older, with maybe
a Synopsys/Designware PCIe host controller?) do you experience these
errors and what delay+retry values are you configuring in order to
get your DUT up an running?

 From what I can tell, the quoted [1] link to Vinod's mail was just
an update during development. This was v3 of the patch series back
then (and it went on to v10 I think, so this wasn't an issue with
what's in the kernel right now).

Note: If you are interested I still got the "uPD720201/uPD720202 User's
Manual" back then from Renesas site. (Nowadays they want you to
register or something.). This document was the base for the code and
maybe there's something in there you can quote to extend the
retries/delays.

(From what I vaguely remember. Most of the transfer was fast and
no retries where necessary, but some register write took so long.
Vinod  also posted hints about a newer firmware for the
uPD720201/uPD720202. Have you tried that as well?)

Regards,
Christian

