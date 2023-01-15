Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43C66B32C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjAOR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjAORZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:25:59 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DC1715;
        Sun, 15 Jan 2023 09:25:59 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15ed38a9b04so8475907fac.8;
        Sun, 15 Jan 2023 09:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=01l/S+PtTgqqdC/hFDSRkBiFz9IelRuDTcqpjSun12w=;
        b=Vx7Xw1uhVjgtb/xjGcnDlIFbqt+0J7sBHcn4xZilVhG49aSPNo0rkMFO8QrkcHmvIB
         3NU8NYa8sOlew2Xr0uVeHrF9+XhAFxUfr76iHaW+ioAyyNfEnEcst+NE1JFvdMYBZ1Tg
         ufIvbuvnoEv7drlt7iXNZk6uId0PGCxGqTMxNJud34jI1ngPwgl+PfUcF43TQAckf5Za
         40zLWzviuh9Nld+Xpp6QLf8yl8PSpdKkMpYnn6Tp9VfZgM7CvfnDFsVf3j98hinTyufW
         AalBUhFiKuGKCYRLTdB5mFyCpItFkC6ZCimBfZafPGuqWRCLIjQ5O4C7ts9NrMG3/kys
         MPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01l/S+PtTgqqdC/hFDSRkBiFz9IelRuDTcqpjSun12w=;
        b=YiXxr/kn7KfXoAkkRihqlY0afmL2PoX7yc97r8GrhQkYkh33aWP7lPyE6FMpiJATfz
         Cp5QyM3+R5Sb4HmAuPRp9hV8YUk4OBj8CEXmpu0kKHG2vjyTC8b0zZBU4k1xVdmWe/sq
         lSxk6UDB4nzEry+F+XlwZfvj0nSCrl9NsJ6+8qYwO+Gmt5YvONgXsCz5OSmT/sHEIJ4+
         TUFBn0a6fl3wg+NjnAXonKiZXWRzAEwWYC5kkQDPX7sEgjcWczwhaZ+ETEFkf/P2oPiA
         Vm4Whj4N2I9EaOR3yQ/IAor8M+UN+JdmZNYjM4MMOUFqfwheu90VGK5c0ASbPdMswJPf
         fELQ==
X-Gm-Message-State: AFqh2koMrCHicITiBviqOl+7kVHlBrpEtnSm8V79UniqGvE3NuBIpQ6F
        S6Jcd7YjnWnf8wYuZrRZ5XxId33iqNQ=
X-Google-Smtp-Source: AMrXdXuHeqSf2bXuQCbmhWMuIY+Mri7/qqYgJSAiC/IiyWtiJIiyXvVwpREezYESry/zSZ7/tyFsUA==
X-Received: by 2002:a05:6871:4307:b0:15f:193d:37f1 with SMTP id lu7-20020a056871430700b0015f193d37f1mr2230762oab.5.1673803558361;
        Sun, 15 Jan 2023 09:25:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id em33-20020a0568705ba100b0014fd7e7c3fesm13325166oab.27.2023.01.15.09.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 09:25:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <371094e6-b805-6e0b-1f03-fb3a113bcb12@roeck-us.net>
Date:   Sun, 15 Jan 2023 09:25:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20230114093246.1933321-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230114093246.1933321-1-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/23 01:32, Badhri Jagan Sridharan wrote:
> On some of the TCPC implementations, when the Type-C port is exposed
> to contaminants, such as water, TCPC stops toggling while reporting OPEN
> either by the time TCPM reads CC pin status or during CC debounce
> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> to restart toggling, the behavior recurs causing redundant CPU wakeups
> till the USB-C port is free of contaminant.
> 
> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> 
> (or)
> 
> [ 7853.867577] Start toggling
> [ 7853.889921] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7855.698765] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [ 7855.698790] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7855.698826] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [ 7855.703559] CC1: 0 -> 0, CC2: 5 -> 5 [state SNK_ATTACH_WAIT, polarity 0, connected]
> [ 7855.856555] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> [ 7855.856581] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7855.856613] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> [ 7856.027744] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> [ 7856.181949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7856.187896] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7857.645630] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [ 7857.647291] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [ 7857.647298] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7857.647310] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [ 7857.808106] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
> [ 7857.808123] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [ 7857.808150] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
> [ 7857.978727] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
> 
> To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
> can implement the check_contaminant callback which is invoked by TCPM
> to evaluate for presence of contaminant. Lower level TCPC driver can
> restart toggling through TCPM_PORT_CLEAN event when the driver detects
> that USB-C port is free of contaminant. check_contaminant callback also
> passes the disconnect_while_debounce flag which when true denotes that
> the CC pins transitioned to OPEN state during the CC debounce window.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v12:
> * None.
> Changes since v11:
> * None.

Why did you drop the Reviewed-by: tags if there was no change ?

Same question applied to the second patch of the series.

Guenter

