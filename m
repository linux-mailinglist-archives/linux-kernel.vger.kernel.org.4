Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB026F3C45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjEBDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBDMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:12:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D7359A;
        Mon,  1 May 2023 20:12:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso2457921b3a.2;
        Mon, 01 May 2023 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682997123; x=1685589123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+tSkDxhHqbUUxjWfqVzBHhBZlJ2vQiPlfYmSSAFcgY=;
        b=pawwxWEyX7yBxnTyfuexDKSaJwCpbr94vJXgZgN2EbBgy8PPtXCcgHBv7pf07H4/F9
         73hzIFEnKZOpXt35+NrxeHAzsPL7BvFqdi1tobl4k/ITk37GG5nnlHShIH2TNOAi8uOt
         HLtw0W/kEI4LLWewbcXAIxA3dtJV0eF6pam0Ueci1uxaYczdezJAz6zEoy6a2F7/Urt0
         fefJll4qUznSmdhBiMzkP+tNJGGrZ51HPW4GExe8dAtBRrpJuYjIgVRtz3JuK3VB49Wc
         m2HQRLXACVLuZYOSAsJt51fZwd/t48SyC+/WMlO+zUrNRlqUugONQjeKv99W8sBE3qp0
         JVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682997123; x=1685589123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+tSkDxhHqbUUxjWfqVzBHhBZlJ2vQiPlfYmSSAFcgY=;
        b=imC9Xj3o6GX4oCNGMxm0Y7EeCehya1dT7QasonXc9jWEh/k9p37RSMUd3AgqbjKOjX
         JrXe1aaWgyOD7P3yOIm9tYNcTrUFQSmfx33wR9S7atry9UU1wzdf49laxMkNQZSlDhWY
         fbKiecqx42E/oQk4XMxFrgZU4NAVg15a2wMnye9/qwD0yjoFN9hLXFs7VpQYdotJoJVk
         i9U6NaHY+2zlIkcrA+WWKqlEW7C7EGgFKm9q7Nfe0YA2dw2uoN31qow/ctYIsSik4xw2
         1Izf8qVIcjbFD4+zbccxQQ7FKpVpTlbISV1xhNQ6V9+V6gXjoj61TToe61LdcoEnp6hf
         cP6Q==
X-Gm-Message-State: AC+VfDzYJAhyx/1FXxaSbQQCvaFzTMLhm14KOX/4AImcXnjRrtGK/tkY
        yNVpuwX1JCnHuFEeGlg2PBw=
X-Google-Smtp-Source: ACHHUZ6LREUiqvaDkCvsB/9IymOddD/j6zF11Z87rXtMOaeU22unwV+/IPzPFEPaxJhs3lPmSaTsRw==
X-Received: by 2002:a05:6a00:1684:b0:63b:1708:10aa with SMTP id k4-20020a056a00168400b0063b170810aamr24353933pfc.34.1682997123279;
        Mon, 01 May 2023 20:12:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0063d642dcd12sm21279676pfg.16.2023.05.01.20.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 20:12:02 -0700 (PDT)
Date:   Mon, 1 May 2023 20:11:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Denose <jdenose@chromium.org>
Cc:     Andrew Duggan <andrew@duggan.us>, Lyude Paul <lyude@redhat.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        "amandhoot12@gmail.com" <amandhoot12@gmail.com>,
        "jdenose@google.com" <jdenose@google.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH v2] Input: synaptics - disable intertouch for Lenovo L440
Message-ID: <ZFB/f0cvwGlr7VeF@google.com>
References: <063c8f77c216ffac463532023009124542d54c19.camel@redhat.com>
 <20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid>
 <CALNJtpXLHHSV8YshUnk0opLNMUJpT7DgBNRYXoP2Yn-fnA8vPA@mail.gmail.com>
 <CALNJtpV4WsknSSfBBer-MM0y_V=O5Fv2Lc3ei3heEyZwvR2rzQ@mail.gmail.com>
 <65C23A49-5A55-4CF4-9AFD-2DA504DAABF5@duggan.us>
 <CALNJtpWOPRB3-0Jw+GJt_D-vjEhbhDRw-Kb3boC0dOU+525fFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNJtpWOPRB3-0Jw+GJt_D-vjEhbhDRw-Kb3boC0dOU+525fFQ@mail.gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:11:28PM -0500, Jonathan Denose wrote:
> Hi Andrew,
> 
> Thanks for your reply. As an update, I was able to try the patch here:
> https://lore.kernel.org/all/YgHTYrODoo2ou49J@google.com/ and it
> resolves the suspend/resume issue on this device. I'm not sure what
> the status of the linked patch is, to me it doesn't look like it was
> merged anywhere.

This patch shoudl have been superseded by:

commit 7b1f781f2d2460693f43d5f764198df558e3494b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue Feb 15 13:32:26 2022 -0800

    Input: psmouse - set up dependency between PS/2 and SMBus companions

    When we switch from emulated PS/2 to native (RMI4 or Elan) protocols, we
    create SMBus companion devices that are attached to I2C/SMBus controllers.
    However, when suspending and resuming, we also need to make sure that we
    take into account the PS/2 device they are associated with, so that PS/2
    device is suspended after the companion and resumed before it, otherwise
    companions will not work properly. Before I2C devices were marked for
    asynchronous suspend/resume, this ordering happened naturally, but now we
    need to enforce it by establishing device links, with PS/2 devices being
    suppliers and SMBus companions being consumers.

    Fixes: 172d931910e1 ("i2c: enable async suspend/resume on i2c client devices")
    Reported-and-tested-by: Hugh Dickins <hughd@google.com>
    Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
    Link: https://lore.kernel.org/r/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com
    Link: https://lore.kernel.org/r/YgwQN8ynO88CPMju@google.com
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Which should have ensured that PS/2 device is resumed first, before
trying to resume RMI interface. I wonder why it is not working for you.

Can you enable logging and see if the order of resume is correct or not.
If it is still wrong we need to figure out why setting the link between
the devices does not have the desired effect.

Thanks.

-- 
Dmitry
