Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD6648FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLJQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 11:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:08:02 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB6B2715;
        Sat, 10 Dec 2022 08:08:01 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1447c7aa004so3358293fac.11;
        Sat, 10 Dec 2022 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X90OAossxf96hzJz48GuBDU3cdz+acl5ootwmwc92vw=;
        b=EHgs57gMzUu90cUfjVA3PB0/tuIxO++M6Haf1jYx+t+LDQhLIvZFW6+BTgz/p1z+Ho
         LoqkJUAg3ZfNBMFemrlo/KqJmpYCEibrS8fVUlAwtjSqyhXGPb1uvOvCwp51mHHZD1Cb
         palK4A9a3TgXmvd+sy5u3g4X3y4JFGnE7XryUptj0JMwhGxEBhkmfPryHRCZpDGKPOrS
         /K8WS1nR246i6VQQcw5v/vgve3teTUso90HZDUkFmdbqEPvS97PooxSOHlilYPOGpLm5
         cnuMICcr1ygrrN6+n7YIq62QtqvobYW5JR8nkBxMOKap2O7M2hZIZpWipA4f4IeEMAwe
         Sraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X90OAossxf96hzJz48GuBDU3cdz+acl5ootwmwc92vw=;
        b=WYehI2BqLuUI1EGlYwseT4Gfxk/v494bI+p1dgbXH7amEtc5LNlz2GSf43omSpCQGJ
         uhvVthRnlQrLacO4ZtAXcET6EcoNxbgmS+YrXL3vIVOnGoWrzge935AiqPhc2pdzofW9
         cXZLKmzaAfhlvOELQx0juXS5hM5miNCpNeyU+K2bK0qq8sAHgTErlVxSo9MVjH6V2dIq
         Chi60XQm89+g2ffbKh7L8+qxVDxT7/oc3qSprP7i5UhI5yChenxYij8ZxGh/ZoEg5JKA
         uKIeKiZ2ShvjzqGml9JsUsZITaVs+2gXPHNYa4T++xsi9iZBHCAlx3Ld9HC5CeFwGhtA
         FMiA==
X-Gm-Message-State: ANoB5pnk3+v93XcxNkb0uonOHxcijHMzF/waTgoxhs/+2oVVT/tFohwK
        LcL36mgXuj87IbXOsgjhHUzYqUNCE50=
X-Google-Smtp-Source: AA0mqf4/enyviU4doy1gifL84yCFW3yO4ZaqSEPM08OXpTK0pkiokzUBnZUnLtcEDEIMPOIuFj+enA==
X-Received: by 2002:a05:6870:88aa:b0:137:3ad9:acca with SMTP id m42-20020a05687088aa00b001373ad9accamr6714430oam.54.1670688480187;
        Sat, 10 Dec 2022 08:08:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kw32-20020a056870ac2000b0013b911d5960sm2432837oab.49.2022.12.10.08.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 08:07:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <52ed8d2f-813f-b9b6-238a-b7764f488924@roeck-us.net>
Date:   Sat, 10 Dec 2022 08:07:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 2/3] usb: typec: tcpci: Add callback for evaluating
 contaminant presence
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20221210061626.948426-1-badhri@google.com>
 <20221210061626.948426-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221210061626.948426-2-badhri@google.com>
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

On 12/9/22 22:16, Badhri Jagan Sridharan wrote:
> This change adds callback to evaluate presence of contaminant in
> the TCPCI layer.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v7:
> * None. Skipped versions by mistake.
> Changes since v6:
> * Removed is_potential_contaminant callback
> Changes since v5:
> * None
> Changes since v4:
> * None
> Changes since v3:
> * None
> Changes since v2:
> * Added tcpci_is_potential_contaminant to offload
> * disconnect_while_debounce logic
> ---
>   drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
>   include/linux/usb/tcpci.h      | 7 +++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index fe781a38dc82..c8e78c13c9c4 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -403,6 +403,14 @@ static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
>   		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
>   }
>   
> +static void tcpci_check_contaminant(struct tcpc_dev *dev)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> +
> +	if (tcpci->data->check_contaminant)
> +		tcpci->data->check_contaminant(tcpci, tcpci->data);
> +}
> +

With this callback to tcpm in place, how does tcpm ever leave the
CHECK_CONTAMINANT state if the low level driver does not support
the callback ?

Thanks,
Guenter


>   static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
>   {
>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -777,6 +785,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>   	tcpci->tcpc.enable_frs = tcpci_enable_frs;
>   	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>   	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
> +	tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
>   
>   	if (tcpci->data->auto_discharge_disconnect) {
>   		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 17657451c762..85e95a3251d3 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -188,6 +188,12 @@ struct tcpci;
>    *		Optional; The USB Communications Capable bit indicates if port
>    *		partner is capable of communication over the USB data lines
>    *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> + * @check_contaminant:
> + *		Optional; The callback is invoked when chiplevel drivers indicated
> + *		that the USB port needs to be checked for contaminant presence.
> + *		Chip level drivers are expected to check for contaminant and call
> + *		tcpm_clean_port when the port is clean to put the port back into
> + *		toggling state.
>    */
>   struct tcpci_data {
>   	struct regmap *regmap;
> @@ -204,6 +210,7 @@ struct tcpci_data {
>   	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
>   	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
>   					     bool capable);
> +	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
>   };
>   
>   struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);

