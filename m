Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5D648E0E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLJJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:58:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581D418B3D;
        Sat, 10 Dec 2022 01:58:56 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so6743486oia.9;
        Sat, 10 Dec 2022 01:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkoBieEJk8eGv6fMfHU7F8Hh1TbVnNB2PYxDiW4oXh4=;
        b=WvP1A91562BxwKqHQd+SB5sVuqZumGKvLJSxCOnWUE8BfCqm/Boc8x+54oXcqA/rP0
         BND5x9XMRHhxQVgv4BCpZyRXfF6wcTEWJzxx4ezyYJvNfTD5Q6omVodRsAJhFSFAn5nq
         D2bBzpxcKT64qjSCpOhSdtPNNHk0+k2mxKOex1/7N74iXSE87RASUOdrirRo/DcYE7bX
         SQTERyBd2i64wRfRfOTmPcYY6JbDNlP6yD6Syu2GpL1DUDFs/Z0eLckrAWLgCJ0/NS4m
         0pdV0ovay+ZCYxV1HQhtnkQvOsj1gsp0sd7QkGBivF9YSUGZNdM+KUW50rDQW4s6q742
         h5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkoBieEJk8eGv6fMfHU7F8Hh1TbVnNB2PYxDiW4oXh4=;
        b=vLmt+SUGmK3sGVERi3/W0SY33+U+8gGNJ7+XmBHHPt8TDwXXTs6/Vc5xGd4tjXnZMH
         HnISoH2H3gqW7MQLwJeZHL0U1lyWpB9uhTS9ieH5mK71nm8zV/DizRz90VyQbFhGQPDP
         X0qpFqALdH/CYuZ1JVWOVsVOPmn1simazz8LBK+aZcetUGyilqxjf39qtUMX+vopZjZp
         lE0B1z8GuC0eKNaF4jFmcpb1Cb+/3lhOgVW/jqol7vJh+DcaOPXtPb7upjuzozO9yLC7
         Sm7Sx9fGnHPzfXk/novxK5w3SXVRSPGt1RWpEeiJb0154xT4bw1V1CEOkQZWKZgtKbf7
         sZvA==
X-Gm-Message-State: ANoB5plGzhRwVfBx5mporAyGHpKcI74DF5sjOu9rzCYifRmLWHJrFY3G
        kLXKSF8sr46slsUmgAHdADpB56b7Tro=
X-Google-Smtp-Source: AA0mqf7WDaupGzickbbiSfBVMDCIcm54F4WUs5ESHG2QjiT/82a9MuOhKOzcgunmnbeHqwaSn0kMFQ==
X-Received: by 2002:a05:6808:6ce:b0:359:fced:b350 with SMTP id m14-20020a05680806ce00b00359fcedb350mr3698041oih.10.1670666335488;
        Sat, 10 Dec 2022 01:58:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d124-20020a4a5282000000b0049f8b4b2095sm1327742oob.44.2022.12.10.01.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 01:58:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e516c19-31f9-c2a7-97da-7c61e5d1d3f0@roeck-us.net>
Date:   Sat, 10 Dec 2022 01:58:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20221210061626.948426-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v9 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
In-Reply-To: <20221210061626.948426-1-badhri@google.com>
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
> that USB-C port is free of contaminant. check_contaminant callback also passes
> the disconnect_while_debounce flag which when true denotes that the CC pins
> transitioned to OPEN state during the CC debounce window.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v7:
> * None. Skipped versions by mistake.
> Changes since v6:
> * folded the debounce logic into tcpm state machine and removed tcpm
> * state export.
> * Added a helper to determine whether the port is in toggling state.
> * Excluded CHECK_CONTAMINANT from tcpm_log.
> Changes since v5:
> * Updated commit message. Removed change id.
> Changes since v4:
> * None
> Changes since v3:
> * None
> Changes since V2:
> * Offloaded tcpm from maintaining disconnect_while_debouncing logic
> * to lower level maxim tcpc driver based on feedback.
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 51 ++++++++++++++++++++++++++++++++++-
>   include/linux/usb/tcpm.h      |  8 ++++++
>   2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 904c7b4ce2f0..5f514e5e6e2a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -36,6 +36,7 @@
>   #define FOREACH_STATE(S)			\
>   	S(INVALID_STATE),			\
>   	S(TOGGLING),			\
> +	S(CHECK_CONTAMINANT),			\
>   	S(SRC_UNATTACHED),			\
>   	S(SRC_ATTACH_WAIT),			\
>   	S(SRC_ATTACHED),			\
> @@ -249,6 +250,7 @@ enum frs_typec_current {
>   #define TCPM_RESET_EVENT	BIT(2)
>   #define TCPM_FRS_EVENT		BIT(3)
>   #define TCPM_SOURCING_VBUS	BIT(4)
> +#define TCPM_PORT_CLEAN		BIT(5)
>   
>   #define LOG_BUFFER_ENTRIES	1024
>   #define LOG_BUFFER_ENTRY_SIZE	128
> @@ -483,6 +485,13 @@ struct tcpm_port {
>   	 * SNK_READY for non-pd link.
>   	 */
>   	bool slow_charger_loop;
> +
> +	/*
> +	 * When true indicates that the lower level drivers indicate potential presence
> +	 * of contaminant in the connector pins based on the tcpm state machine
> +	 * transitions.
> +	 */
> +	bool potential_contaminant;
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *dentry;
>   	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -647,7 +656,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
>   	/* Do not log while disconnected and unattached */
>   	if (tcpm_port_is_disconnected(port) &&
>   	    (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
> -	     port->state == TOGGLING))
> +	     port->state == TOGGLING || port->state == CHECK_CONTAMINANT))
>   		return;
>   
>   	va_start(args, fmt);
> @@ -3904,15 +3913,28 @@ static void run_state_machine(struct tcpm_port *port)
>   	unsigned int msecs;
>   	enum tcpm_state upcoming_state;
>   
> +	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
> +		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
> +						port->state == SRC_UNATTACHED) ||
> +					       (port->enter_state == SNK_ATTACH_WAIT &&
> +						port->state == SNK_UNATTACHED));
> +
>   	port->enter_state = port->state;
>   	switch (port->state) {
>   	case TOGGLING:
>   		break;
> +	case CHECK_CONTAMINANT:
> +		port->tcpc->check_contaminant(port->tcpc);
> +		break;
>   	/* SRC states */
>   	case SRC_UNATTACHED:
>   		if (!port->non_pd_role_swap)
>   			tcpm_swap_complete(port, -ENOTCONN);
>   		tcpm_src_detach(port);
> +		if (port->potential_contaminant) {
> +			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> +			break;
> +		}
>   		if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
>   			tcpm_set_state(port, TOGGLING, 0);
>   			break;
> @@ -4150,6 +4172,10 @@ static void run_state_machine(struct tcpm_port *port)
>   			tcpm_swap_complete(port, -ENOTCONN);
>   		tcpm_pps_complete(port, -ENOTCONN);
>   		tcpm_snk_detach(port);
> +		if (port->potential_contaminant) {
> +			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
> +			break;
> +		}
>   		if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
>   			tcpm_set_state(port, TOGGLING, 0);
>   			break;
> @@ -4926,6 +4952,9 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>   		else if (tcpm_port_is_sink(port))
>   			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
>   		break;
> +	case CHECK_CONTAMINANT:
> +		/* Wait for Toggling to be resumed */
> +		break;
>   	case SRC_UNATTACHED:
>   	case ACC_UNATTACHED:
>   		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
> @@ -5425,6 +5454,11 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
>   			port->vbus_source = true;
>   			_tcpm_pd_vbus_on(port);
>   		}
> +		if (events & TCPM_PORT_CLEAN) {
> +			tcpm_log(port, "port clean");
> +			if (port->state == CHECK_CONTAMINANT)
> +				tcpm_set_state(port, TOGGLING, 0);
> +		}
>   

I just realized: This never calls tcpm_start_toggling(), meaning the
start_toggling() callback will never be called. Worse, if the callback
doesn't exist the state machine may be stuck. How does the state machine
ever really start toggling in this situation ?

Thanks,
Guenter

>   		spin_lock(&port->pd_event_lock);
>   	}
> @@ -5477,6 +5511,21 @@ void tcpm_sourcing_vbus(struct tcpm_port *port)
>   }
>   EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
>   
> +void tcpm_port_clean(struct tcpm_port *port)
> +{
> +	spin_lock(&port->pd_event_lock);
> +	port->pd_events |= TCPM_PORT_CLEAN;
> +	spin_unlock(&port->pd_event_lock);
> +	kthread_queue_work(port->wq, &port->event_work);
> +}
> +EXPORT_SYMBOL_GPL(tcpm_port_clean);
> +
> +bool tcpm_port_is_toggling(struct tcpm_port *port)
> +{
> +	return port->port_type == TYPEC_PORT_DRP && port->state == TOGGLING;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
> +
>   static void tcpm_enable_frs_work(struct kthread_work *work)
>   {
>   	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index bffc8d3e14ad..ab7ca872950b 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -114,6 +114,11 @@ enum tcpm_transmit_type {
>    *              Optional; The USB Communications Capable bit indicates if port
>    *              partner is capable of communication over the USB data lines
>    *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> + * @check_contaminant:
> + *		Optional; The callback is called when CC pins report open status
> + *		at the end of the deboumce period or when the port is still
> + *		toggling. Chip level drivers are expected to check for contaminant
> + *		and call tcpm_clean_port when the port is clean.
>    */
>   struct tcpc_dev {
>   	struct fwnode_handle *fwnode;
> @@ -148,6 +153,7 @@ struct tcpc_dev {
>   						 bool pps_active, u32 requested_vbus_voltage);
>   	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>   	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
> +	void (*check_contaminant)(struct tcpc_dev *dev);
>   };
>   
>   struct tcpm_port;
> @@ -165,5 +171,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>   			       enum tcpm_transmit_status status);
>   void tcpm_pd_hard_reset(struct tcpm_port *port);
>   void tcpm_tcpc_reset(struct tcpm_port *port);
> +void tcpm_port_clean(struct tcpm_port *port);
> +bool tcpm_port_is_toggling(struct tcpm_port *port);
>   
>   #endif /* __LINUX_USB_TCPM_H */
> 
> base-commit: 1524ceb14dd5ebd6f724d993c5ec1a9a8d445d8e

