Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7F720A6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjFBUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjFBUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:39:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA4E4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:39:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a7e639656so2706354276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685738388; x=1688330388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcbrNotSjhSnytv88BRNBehcLgqQnUnDmlY833J1FEc=;
        b=GddNuxWc0Xztueg7UTqeRwXEs2bA2rtW3YY/q2fGYNU6RRb5pt/hyme3BJzySUIIsF
         qPdyQTdT4GRMIwtdXdUkmOYocrpRhZnNT2njbVrLO5CUvKCxGhxHtT53gcsGxMlKkDkQ
         Q9uPtWoyeskmOrdc9+l5ijZIVlVqKSU/zAPQf8VJukw3gqQYGugmbPhpvzzogAjkL4VW
         Gmdq3vrVPwFTnxlzAMNNCAvDbgRFnNtp3+yMt35oYKoklU+r3CFTzW+hxToeKTGBIB5b
         KnrhulK12+FOoVX7IFN/2Vbj8PPbI9gP5cnX5d9wfKCXY7pLEzHBICxWnm3vRd96t748
         npIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738388; x=1688330388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcbrNotSjhSnytv88BRNBehcLgqQnUnDmlY833J1FEc=;
        b=a0W3Ks11MQaxnfnMQLmSfEFQYLwlUwU+hyka/NYXyydclyFTx9AWCrpy0F3uYbKdEM
         GWT7YkPheYpzqFk77KRoUDPCj/e2jYdAsln9pehC3+PUCpkRGlPH736hqtEDRC1zbHLD
         PdioWdQtMXup5PsbCohr9ykfGw64b4uqmHRKXVtubEzsRvWt7SVnvoBQ3EZ2if3ONYe3
         gZvQ0k3gCIbjHGsMwSVwvTwqP2v0mGV6NcXkPbk3Niqwj/NhnsqW0uHpWm/ICo0gSSKc
         EoKS3SNb2uL6GTNrjFe4Pl5Md3mabajt/FJiEjLa6U9kLeserO1NmZH0QVYvbkWobShs
         uXCA==
X-Gm-Message-State: AC+VfDzxKCRQ6l7qc/i/94Ezcvu4F8leM4jX3ytFNKuCBbHnYLO+rPB/
        tuoDMZdgou26i6fXXIsKWFx2mA==
X-Google-Smtp-Source: ACHHUZ4brU+FGPNptWu9TNFJgrSRGDJRjkPjjwwncDyQvxX8v60aoEE9+HxkTmf9uYdXrQtaxvmjmg==
X-Received: by 2002:a25:2b87:0:b0:ba8:66fb:dd86 with SMTP id r129-20020a252b87000000b00ba866fbdd86mr4304797ybr.25.1685738387969;
        Fri, 02 Jun 2023 13:39:47 -0700 (PDT)
Received: from [192.168.60.239] (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090abe0e00b0023a84911df2sm1619241pjs.7.2023.06.02.13.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:39:47 -0700 (PDT)
Message-ID: <72b8f300-429c-1bbc-16bd-e3cd783ad107@google.com>
Date:   Fri, 2 Jun 2023 13:39:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] usb: gadget: uvc: queue empty isoc requests if no video
 buffer is available
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eino-Ville Talvala (Eddy)" <etalvala@google.com>,
        Jayant Chowdhary <jchowdhary@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508231103.1621375-1-arakesh@google.com>
 <20230602151916.GH26944@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <20230602151916.GH26944@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 08:19, Laurent Pinchart wrote:
> Hi Avichal,
> 
> Thank you for the patch.
> 
> On Mon, May 08, 2023 at 04:11:03PM -0700, Avichal Rakesh wrote:
>> ISOC transfers expect a certain cadence of requests being queued. Not
>> keeping up with the expected rate of requests results in missed ISOC
>> transfers (EXDEV). The application layer may or may not produce video
>> frames to match this expectation, so uvc gadget driver must handle cases
>> where the application is not queuing up buffers fast enough to fulfill
>> ISOC requirements.
> 
> I think the application *must* not produce video frames to match the
> expectations. If it did, it would mean that it would either have to use
> more than the available ISOC bandwidth (which is obviously bad), or use
> *exactly* the ISOC bandwidth. Unless the application performs rate
> matching (which would require information about the USB timings that
> isn't available to userspace as far as I can tell), that's not possible.

Ah, that is a good point. This makes it sound like the userspace application
is responsible for maintaining the cadence, which is false. Tweaked the
language to (hopefully) sound less blame-y.
> 
>> Currently, uvc gadget driver waits for new video buffer to become available
>> before queuing up usb requests. With this patch the gadget driver queues up
>> 0 length usb requests whenever there are no video buffers available. The
>> USB controller's complete callback is used as the limiter for how quickly
>> the 0 length packets will be queued. Video buffers are still queued as
>> soon as they become available.
>>
>> Link: https://lore.kernel.org/CAMHf4WKbi6KBPQztj9FA4kPvESc1fVKrC8G73-cs6tTeQby9=w@mail.gmail.com/
>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>> ---
>>  drivers/usb/gadget/function/uvc_video.c | 32 ++++++++++++++++++-------
>>  1 file changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
>> index dd1c6b2ca7c6..e81865978299 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -386,6 +386,9 @@ static void uvcg_video_pump(struct work_struct *work)
>>  	struct uvc_buffer *buf;
>>  	unsigned long flags;
>>  	int ret;
>> +	bool buf_int;
>> +	/* video->max_payload_size is only set when using bulk transfer */
>> +	bool is_bulk = video->max_payload_size;
> 
> Let's rename buf_int to buf_done, that matches the intent of the code
> better.
> 
> Could you reorder the fields by line length ?
> 
> 	struct uvc_video *video = container_of(work, struct uvc_video, pump);
> 	struct uvc_video_queue *queue = &video->queue;
> 	/* video->max_payload_size is only set when using bulk transfer */
> 	bool is_bulk = video->max_payload_size;
> 	struct usb_request *req = NULL;
> 	struct uvc_buffer *buf;
> 	unsigned long flags;
> 	bool buf_done;
> 	int ret;
> 
>>  
>>  	while (video->ep->enabled) {
>>  		/*
>> @@ -408,20 +411,35 @@ static void uvcg_video_pump(struct work_struct *work)
>>  		 */
>>  		spin_lock_irqsave(&queue->irqlock, flags);
>>  		buf = uvcg_queue_head(queue);
>> -		if (buf == NULL) {
>> +
>> +		if (buf != NULL) {
>> +			video->encode(req, video, buf);
>> +			/* Always interrupt for the last request of a video buffer */
> 
> I would drop this comment, and ... (see below)
> 
>> +			buf_int = buf->state == UVC_BUF_STATE_DONE;
>> +		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>> +			/*
>> +			 * No video buffer available; the queue is still connected and
>> +			 * we're traferring over ISOC. Queue a 0 length request to
> 
> s/traferring/transferring/
> 
>> +			 * prevent missed ISOC transfers.
>> +			 */
>> +			req->length = 0;
>> +			buf_int = false;
>> +		} else {
>> +			/*
>> +			 * Either queue has been disconnected or no video buffer
> 
> s/Either queue/Either the queue/
> 
>> +			 * available to bulk transfer. Either way, stop processing
> 
> s/to bulk/for bulk/
> 
>> +			 * further.
>> +			 */
>>  			spin_unlock_irqrestore(&queue->irqlock, flags);
>>  			break;
>>  		}
>>  
>> -		video->encode(req, video, buf);
>> -
>>  		/*
>>  		 * With usb3 we have more requests. This will decrease the
>>  		 * interrupt load to a quarter but also catches the corner
>>  		 * cases, which needs to be handled.
>>  		 */
> 
> ... and expand this:
> 
>   		/*
> 		 * With USB3 handling more requests at a higher speed, we can't
> 		 * afford to generate an interrupt for every request. Decide to
> 		 * interrupt:
> 		 *
> 		 * - When no more requests are available in the free queue, as
> 		 *   this may be our last chance to refill the endpoint's
> 		 *   request queue.
> 		 *
> 		 * - When this is request is the last request for the video
> 		 *   buffer, as we want to start sending the next video buffer
> 		 *   ASAP in case it doesn't get started already in the next
> 		 *   iteration of this loop.
> 		 *
> 		 * - Four times over the length of the requests queue (as
> 		 *   indicated by video->uvc_num_requests), as a trade-off
> 		 *   between latency and interrupt load.
> 		 */
> 
> And now that I've written this, I wonder if we could drop the second
> case. Now that we have a guarantee we will queue 0-length requests after
> the current buffer if no other buffer is available, I don't think we
> need to make the last request of a buffer a special case. It even seems
> to me that we could drop the first case too, and just interrupt 4 times
> over the length of the requests queue. What do you think ?

The complete callback of the last request for a buffer is used to return the
buffer back to the vb2 framework, which could in the worst case get
delayed by 15 requests. This is probably not a functional issue, as we
already see system latencies far greater than the 2ms that would occur from
those 15 requests, but I think it is a good invariant to have to try and 
minimize any latency jitters when interacting with the userspace application.

On the other hand, removing it does make the code much simpler, so if you
feel strongly about it, I am happy to drop the second case.
 
> 
>> -		if (list_empty(&video->req_free) ||
>> -		    buf->state == UVC_BUF_STATE_DONE ||
>> +		if (list_empty(&video->req_free) || buf_int ||
>>  		    !(video->req_int_count %
>>  		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>>  			video->req_int_count = 0;
>> @@ -441,8 +459,7 @@ static void uvcg_video_pump(struct work_struct *work)
>>  
>>  		/* Endpoint now owns the request */
>>  		req = NULL;
>> -		if (buf->state != UVC_BUF_STATE_DONE)
>> -			video->req_int_count++;
>> +		video->req_int_count++;
>>  	}
>>  
>>  	if (!req)
>> @@ -527,4 +544,3 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>>  			V4L2_BUF_TYPE_VIDEO_OUTPUT, &video->mutex);
>>  	return 0;
>>  }
>> -
> 

Thank you for the review, sent out a v2 with the comments addressed!

- Avi.
