Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3022A74A5FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGFVhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGFVhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE551995;
        Thu,  6 Jul 2023 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vlZu/ebJ1EhDKmb1a7R1ZVtW/YOo80Vceots8FLx5Q4=; b=Eyxqr20dpKk4EHZrrE9px0CWy4
        c1CPFCEhJG1cr441SIj9sXpJKY2u4PICCyOszPNcxbj3Qlm2vlqbVu8C+xmr9IwrteGtRVEaxIq53
        AnK9LubKd6zeUj5nQ9ld6IjZtBT8o7cL90gHaP7107+4LqG2vuYu+rxtt045C8JMoSuLWe3QuQMv0
        2SNyFs+wK5hLq9r//YWJpwVydFKgRsFLAVaKwy7ekw0K6g31ekoPX2Fhmh/OQX803/i6xfIuGiOKc
        cz79X6tBooG9nzfqNBQlHiMqu+Fm27oUNEJvJ2M1U46nEGqjb3Nh0X4fkkBSMcTrZp797WKFt/Ise
        Ao8NuP7Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHWfS-002kQB-1l;
        Thu, 06 Jul 2023 21:37:38 +0000
Message-ID: <e44dacf9-3945-312d-0a22-6391d5e67667@infradead.org>
Date:   Thu, 6 Jul 2023 14:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 2/2] fpga: bridge: fix kernel-doc
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230706142755.124879-1-marpagan@redhat.com>
 <20230706142755.124879-3-marpagan@redhat.com>
 <a3da8412-2e13-6b25-346b-da53414f5dba@infradead.org>
In-Reply-To: <a3da8412-2e13-6b25-346b-da53414f5dba@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 7/6/23 14:35, Randy Dunlap wrote:
> HI--
> 
> On 7/6/23 07:27, Marco Pagani wrote:
>> Fix the following warnings issued by the kernel-doc script:
>>
>> drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
>> drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
>> drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
>> drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
>> drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'
>>
>> - Extend the return description of of_fpga_bridge_get() to include the
>>   case when try_module_get() fails.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a6c25dee9cc1..0b76c67c50e5 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -87,12 +87,13 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>>  /**
>>   * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
>>   *
>> - * @np: node pointer of an FPGA bridge
>> - * @info: fpga image specific information
>> + * @np: node pointer of an FPGA bridge.
>> + * @info: fpga image specific information.
> 
> Those are not sentences. There is no reason that a period ('.') is needed
> to end those lines. OTOH, the maintainers can do as they like with it.
> 
> The rest looks good. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
>>   *
>> - * Return fpga_bridge struct if successful.
>> - * Return -EBUSY if someone already has a reference to the bridge.
>> - * Return -ENODEV if @np is not an FPGA Bridge.
>> + * Return:
>> + * * fpga_bridge struct pointer if successful.
>> + * * -EBUSY if someone already has a reference to the bridge.
>> + * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
>>   */
>>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>>  				       struct fpga_image_info *info)
>> @@ -155,9 +156,9 @@ EXPORT_SYMBOL_GPL(fpga_bridge_put);
>>   * fpga_bridges_enable - enable bridges in a list
>>   * @bridge_list: list of FPGA bridges
>>   *
>> - * Enable each bridge in the list.  If list is empty, do nothing.
>> + * Enable each bridge in the list. If list is empty, do nothing.

These (multiple) 2-space to 1-space changes also are not necessary but are at the
discretion of the maintainers.

>>   *
>> - * Return 0 for success or empty bridge list; return error code otherwise.
>> + * Return: 0 for success or empty bridge list or an error code otherwise.
>>   */
>>  int fpga_bridges_enable(struct list_head *bridge_list)
>>  {
>> @@ -179,9 +180,9 @@ EXPORT_SYMBOL_GPL(fpga_bridges_enable);
>>   *
>>   * @bridge_list: list of FPGA bridges
>>   *
>> - * Disable each bridge in the list.  If list is empty, do nothing.
>> + * Disable each bridge in the list. If list is empty, do nothing.
>>   *
>> - * Return 0 for success or empty bridge list; return error code otherwise.
>> + * Return: 0 for success or empty bridge list or an error code otherwise.
>>   */
>>  int fpga_bridges_disable(struct list_head *bridge_list)
>>  {
>> @@ -230,7 +231,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>>   *
>>   * Get an exclusive reference to the bridge and it to the list.
>>   *
>> - * Return 0 for success, error code from of_fpga_bridge_get() otherwise.
>> + * Return: 0 for success, error code from of_fpga_bridge_get() otherwise.
>>   */
>>  int of_fpga_bridge_get_to_list(struct device_node *np,
>>  			       struct fpga_image_info *info,
>> @@ -260,7 +261,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>>   *
>>   * Get an exclusive reference to the bridge and it to the list.
>>   *
>> - * Return 0 for success, error code from fpga_bridge_get() otherwise.
>> + * Return: 0 for success, error code from fpga_bridge_get() otherwise.
>>   */
>>  int fpga_bridge_get_to_list(struct device *dev,
>>  			    struct fpga_image_info *info,
> 

-- 
~Randy
