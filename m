Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72835667844
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbjALO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjALOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:55:34 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9714D21;
        Thu, 12 Jan 2023 06:42:52 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15027746720so19027186fac.13;
        Thu, 12 Jan 2023 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yOvEekganhspueWhowVp1UU/Ia1S9xjLH34IGLVX6MA=;
        b=TXmaLsiijehOw7IRVAmrolOSCc3dm+FAYYIJ5PxZVlMm2uiC7bIFpFczi1T9lxHHlp
         xZ5xu9CiQI7jzucCB9bhiUKm/cBDEBrmZVwEyLFjtEmnwfQoeur4CYba2T9ar+GBkzdc
         nzf2V0O4vAXCCZ/R6d/8TYOnnuXU5s8/lr/6VHhLxcsN4UflRQ+hoXQljOuLQrcxbAPw
         rI6XOzchEDZsvlCIx5Osij9gwg7e8P8UOT9AV8yaJNu0BrWfba0PJ8+Mg32x7csJAs19
         dBEkYEmkSs6/pBJKQWJH+Rw6CVx0jktUKgNuALPGciGoHoBYfExmudQtO7fO5vxftRY0
         Hc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOvEekganhspueWhowVp1UU/Ia1S9xjLH34IGLVX6MA=;
        b=uqhj9uq23LZFH8xh83me1rx1hL0x/55EARWiwGNH12YzapvWP2TBOBg+PZoIGaYU6K
         G0iFfB0Gprmaft6Kq3S1j4rDNp9On9iu189+evXGCnrgn04rO05GSzsnpmWtGsxyFCyJ
         87Z/Ju+Cr+izrMF8/ee43M9Rapb+nswUjwIxB3eVmVZmhB9omIUMx6wykz7puhE2Lu7c
         tRX92yhLIo0lRaDrnAY0CTTsmpmRAmrePpDKzxgnzPmnUcYPxv0V/IvnM1eCrac2zQEt
         5U0vcKjFpRi5CYtQ1yma8aJNNyIE532YCdvvJLQli1219VtvdA16u57l/UCjixtIm8KF
         B+qA==
X-Gm-Message-State: AFqh2kqC77GWGKCLhFMTlRP1yI9+tUtqEYXXvmTa5K3PYRRSvGkMwYiD
        cAnMgNBmPK/VdmdTLK3+vkw=
X-Google-Smtp-Source: AMrXdXvgTBx3/KXgalLdTo/pOKSzAMJ1Ccv4D4GuGjFShJNhjRqKBCHPVJ3Wbpgj/GogeWuqD/s/yA==
X-Received: by 2002:a05:6870:2a4b:b0:15e:d113:d145 with SMTP id jd11-20020a0568702a4b00b0015ed113d145mr448679oab.21.1673534572151;
        Thu, 12 Jan 2023 06:42:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020a056870d28900b0014b8347e1e3sm8975429oae.12.2023.01.12.06.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:42:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <32a7bb3f-29ec-a5d3-c8ac-998f5714ba27@roeck-us.net>
Date:   Thu, 12 Jan 2023 06:42:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v11 2/3] usb: typec: tcpci: Add callback for evaluating
 contaminant presence
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20221223102122.1038499-1-badhri@google.com>
 <20221223102122.1038499-2-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221223102122.1038499-2-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 02:21, Badhri Jagan Sridharan wrote:
> This change adds callback to evaluate presence of contaminant in
> the TCPCI layer.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v10:
> * None
> Changes since v9:
> * Check for presence of low level check_contaminant before installing tcpc.check_contaminant.
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
>   drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
>   include/linux/usb/tcpci.h      |  7 +++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index fe781a38dc82..699539e1be06 100644
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
>   static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
>   {
>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -778,6 +786,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>   	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
>   	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
>   
> +	if (tcpci->data->check_contaminant)
> +		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
> +
>   	if (tcpci->data->auto_discharge_disconnect) {
>   		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
>   		tcpci->tcpc.set_auto_vbus_discharge_threshold =
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

