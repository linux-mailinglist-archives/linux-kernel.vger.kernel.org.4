Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C5742B65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjF2Ri2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjF2RiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:38:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F496B9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:38:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55ac628e3cfso557046a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688060302; x=1690652302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOSEOh3ksJxYwllcGZgLkwfHE4QYamnIs/PzzPS3s6g=;
        b=JWTpaST/8L7fWpATJmzUZJrQRkY6MCj4ZNGt2a0NbectQmIKTp6ZC7gpGsmgQzwuF0
         YZ4Iev9H6ZVKfaheri6Z5nXHAf6ICx+T5Glw1OMFNkCy+UuJg4wWGySsiG8fjRwVAR6L
         k+rUAJvYYU+qMBE/kqJZsfNkmf9QSAMifwWaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688060302; x=1690652302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOSEOh3ksJxYwllcGZgLkwfHE4QYamnIs/PzzPS3s6g=;
        b=AQrfEJ3OiOVPHJWwkvDuvrgoWfalo4g18NFmo013TzCI9grsRYNwpmLS2cMk602tNw
         GQUYwtLiQtU2Qe0LXP6cMcOLnuIwvwj/6DuhQOLC2vz3JJUfDeMR98nii6T0Hic+FpmA
         uHqSPQA7byoS2F1B5hIooGGwtVTi22vAG60ooIFScVoI+mV/SMvHv1X5MOBWfz+TrWDK
         3rkeN29XuxlCrpEk+aSHmu7r9cjNZcbi6wHAIVKjBtr2btIk1MACWRV4MmOLQ1maebii
         GLR6PsSMkN+I6SjhK5pM51/7qadC6Bu/lBfSvHXL0m6CV5rpseoaUKnfu8wj+nOrNR7W
         VuEA==
X-Gm-Message-State: ABy/qLZ1XzyG5ieQPKd+HCVVPwM+89fjIRZwOvXN2tfkg3Cua2zDo1er
        2AplkZPyccXDBCeqxHEX4VxzDw==
X-Google-Smtp-Source: APBJJlHi4g7DO0fEZZ6CtOpDwyuSrmXDkk4GQ7/MCdgyUqwoCF+WFhUv8S7+BeU1WFQcbjePIbMmBA==
X-Received: by 2002:a17:90a:a88c:b0:263:69c7:f494 with SMTP id h12-20020a17090aa88c00b0026369c7f494mr180158pjq.8.1688060302568;
        Thu, 29 Jun 2023 10:38:22 -0700 (PDT)
Received: from chromium.org (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id lf14-20020a17090b484e00b0026094c23d0asm9530866pjb.17.2023.06.29.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:38:22 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:38:20 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, bleung@chromium.org
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Message-ID: <ZJ3BjFExLBWXZxqm@chromium.org>
References: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
 <20230628173727.701140-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628173727.701140-2-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

Thanks for sending the patch.

On Jun 28 10:37, Utkarsh Patel wrote:
> Connector class driver only configure cable type active or passive.
> With this change it will also configure if the cable type is retimer or

nit: Please use imperative form ("Configure if the cable type is...")

> redriver if required by AP. This detail will be provided as a part of
> cable discover mode VDO.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> ---
> Changes in v2:
>  - Implemented use of cable discover mode vdo.
>  - Removed adittional changes to host command. 
> ---
> 
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 25f9767c28e8..557f396d1c00 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -406,6 +406,25 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
>  	return ret;
>  }
>  
> +static int cros_typec_get_cable_vdo(struct cros_typec_data *typec, int port_num,
> +				    uint16_t svid)

u16 type is used in the kernel.

Also, if this function returns a VDO, the return type should be u32, but... (see later)

> +{
> +	struct cros_typec_port *port = typec->ports[port_num];

Pass the struct cros_typec_port directly (and then drop the port_num argument).

> +	struct list_head *head = &port->plug_mode_list;
> +	struct cros_typec_altmode_node *node;
> +
> +	list_for_each_entry(node, head, list) {
> +		if (node->amode->svid == svid)
> +			break;

Return the vdo here directly; that way, if you reach past the list iteration,
we know for sure the SVID wasn't found and you can unconditionally return the error
case.

> +	}
> +
> +	if (node->amode->svid != svid)
> +		return 0;

I think it is more correct here to have an int return type (so the "not found" case can
return -1 or the right error code), and then have the cable VDO as a pointer argument.

> +
> +	return node->amode->vdo;
> +}
> +
> +
>  /*
>   * Spoof the VDOs that were likely communicated by the partner for TBT alt
>   * mode.
> @@ -416,6 +435,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct typec_thunderbolt_data data;
> +	uint32_t cable_vdo;
u32.

>  	int ret;
>  
>  	if (typec->pd_ctrl_ver < 2) {
> @@ -442,6 +462,11 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
>  
>  	data.cable_mode |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);

Probably a separate patch, but can we get rid of this too, since the cable_vdo should
have this information?

>  
> +	cable_vdo = cros_typec_get_cable_vdo(typec, port_num, USB_TYPEC_TBT_SID);
> +
> +	if (cable_vdo & TBT_CABLE_RETIMER)
> +		data.cable_mode |= TBT_CABLE_RETIMER;

Why just not or the cable_vdo into existing cable_mode"? :

data.cable_mode |= cable_vdo;

> +
>  	/* Enter Mode VDO */
>  	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
>  
> @@ -513,17 +538,23 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct enter_usb_data data;
> +	uint32_t cable_vdo;

u32

>  
>  	data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
>  
> +	cable_vdo = cros_typec_get_cable_vdo(typec, port_num, USB_TYPEC_TBT_SID);
> +
>  	/* Cable Speed */
>  	data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
>  
>  	/* Cable Type */
>  	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
>  		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
> -	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +	else if (cable_vdo & TBT_CABLE_RETIMER)
>  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> +	else if (!(cable_vdo & TBT_CABLE_RETIMER) &&

The !(cable_vdo & TBT_CABLE_RETIMER) check shouldn't be necessary; the
earlier "else if" already ensures that by the time we reach here, this
clause is satisfied.

> +		 (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE))
> +		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
>  
>  	data.active_link_training = !!(pd_ctrl->control_flags &
>  				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> -- 
> 2.25.1
> 
